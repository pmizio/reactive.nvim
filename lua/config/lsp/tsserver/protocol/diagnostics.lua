local log = require "vim.lsp.log"
local constants = require "config.lsp.tsserver.protocol.constants"
local utils = require "config.lsp.tsserver.protocol.utils"

local SOURCE = "tsserver"

local M = {}

local update_events_tracker = {}
local opened_files_cache = {}
local last_diagnostic_request = nil
local diagnostics_cache = {}

M.track_changes = function(method, params, seq)
  local text_document = params.textDocument

  if not text_document then
    return nil
  end

  local file_name = vim.uri_to_fname(text_document.uri)

  if method == constants.LspMethods.DidOpen then
    opened_files_cache[file_name] = true
    update_events_tracker[seq] = true
  elseif method == constants.LspMethods.DidChange then
    update_events_tracker[seq] = true
  elseif method == constants.LspMethods.DidClose then
    opened_files_cache[file_name] = nil
  end
end

local severity_map = {
  suggestion = constants.DiagnosticSeverity.Hint,
  warning = constants.DiagnosticSeverity.Warning,
  error = constants.DiagnosticSeverity.Error,
}

local category_to_severity = function(category)
  local severity = severity_map[category]
  if not severity then
    log.warn("[tsserver] cannot find correct severity for: " .. category)
    return constants.DiagnosticSeverity.Error
  end

  return severity
end

M.handler = function(response, encode_and_send, notification)
  local seq = response.request_seq

  if update_events_tracker[seq] then
    update_events_tracker[seq] = nil

    local files = vim.tbl_keys(opened_files_cache)

    for _, file in pairs(files) do
      diagnostics_cache[file] = {}
    end

    -- TODO: add debounce
    local new_seq = encode_and_send {
      command = constants.CommandTypes.Geterr,
      arguments = {
        delay = 0,
        files = files,
      },
    }

    last_diagnostic_request = new_seq

    return nil
  end

  if response.type ~= "event" then
    return nil
  end

  if
    response.event == constants.DiagnosticEventKind.SemanticDiag
    or response.event == constants.DiagnosticEventKind.SyntaxDiag
    or response.event == constants.DiagnosticEventKind.SuggestionDiag
  then
    for _, diagnostic in pairs(response.body.diagnostics) do
      table.insert(diagnostics_cache[response.body.file], {
        -- TODO: handle `relatedInformation`
        message = diagnostic.text,
        source = SOURCE,
        code = diagnostic.code,
        severity = category_to_severity(diagnostic.category),
        range = utils.convert_tsserver_range_to_lsp(diagnostic),
      })
    end
  end

  if
    response.event == constants.RequestCompletedEventName
    and last_diagnostic_request == response.body.request_seq
  then
    last_diagnostic_request = nil

    vim.schedule(function()
      for file, diagnostics in pairs(diagnostics_cache) do
        notification(constants.LspMethods.PublishDiagnostics, {
          uri = vim.uri_from_fname(file),
          diagnostics = diagnostics,
        })
      end
    end)
  end

  return nil
end

return M
