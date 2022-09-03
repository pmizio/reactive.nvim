local log = require "vim.lsp.log"
local constants = require "config.lsp.tsserver.protocol.constants"
local utils = require "config.lsp.tsserver.protocol.utils"

local SOURCE = "tsserver"

local severity_map = {
  suggestion = constants.DiagnosticSeverity.Hint,
  warning = constants.DiagnosticSeverity.Warning,
  error = constants.DiagnosticSeverity.Error,
}

local DiagnosticsService = {
  tracked_request = nil,
  diagnostics_cache = {},
}

function DiagnosticsService:new(server_name)
  local tbl = {}
  setmetatable(tbl, self)
  self.__index = self
  self.server_name = server_name

  return tbl
end

function DiagnosticsService:_request_diagnostics(encode_and_send)
  local client = vim.lsp.get_active_clients({ name = self.server_name })[1]

  if client then
    vim.schedule(function()
      local attached_bufs = {}

      for _, bufnr in pairs(vim.api.nvim_list_bufs()) do
        if vim.lsp.buf_is_attached(bufnr, client.id) then
          table.insert(attached_bufs, vim.api.nvim_buf_get_name(bufnr))
        end
      end

      if #attached_bufs <= 0 then
        return
      end

      for _, file in pairs(attached_bufs) do
        self.diagnostics_cache[file] = {}
      end

      -- TODO: maybe requests need some debounce but it need more testing
      self.tracked_request = encode_and_send {
        command = constants.CommandTypes.Geterr,
        arguments = {
          delay = 0,
          files = attached_bufs,
        },
      }
    end)
  end
end

local category_to_severity = function(category)
  local severity = severity_map[category]
  if not severity then
    log.warn("[tsserver] cannot find correct severity for: " .. category)
    return constants.DiagnosticSeverity.Error
  end

  return severity
end

local convert_related_information = function(related_information)
  return vim.tbl_map(function(info)
    return {
      message = info.message,
      location = {
        uri = vim.uri_from_fname(info.span.file),
        range = utils.convert_tsserver_range_to_lsp(info.span),
      },
    }
  end, related_information)
end

function DiagnosticsService:_collect_diagnostics(response)
  for _, diagnostic in pairs(response.body.diagnostics) do
    table.insert(self.diagnostics_cache[response.body.file], {
      message = diagnostic.text,
      source = SOURCE,
      code = diagnostic.code,
      severity = category_to_severity(diagnostic.category),
      range = utils.convert_tsserver_range_to_lsp(diagnostic),
      relatedInformation = diagnostic.relatedInformation and convert_related_information(
        diagnostic.relatedInformation
      ),
    })
  end
end

function DiagnosticsService:_publish_diagnostics(response, notification)
  if self.tracked_request == response.body.request_seq then
    self.tracked_request = nil

    vim.schedule(function()
      for file, diagnostics in pairs(self.diagnostics_cache) do
        notification(constants.LspMethods.PublishDiagnostics, {
          uri = vim.uri_from_fname(file),
          diagnostics = diagnostics,
        })
      end
    end)
  end
end

function DiagnosticsService:setup_event_emitter(event_emitter, encode_and_send, notification)
  event_emitter:add_listener(constants.CommandTypes.UpdateOpen, function()
    self:_request_diagnostics(encode_and_send)
  end)

  event_emitter:add_listener({
    constants.DiagnosticEventKind.SyntaxDiag,
    constants.DiagnosticEventKind.SemanticDiag,
    constants.DiagnosticEventKind.SuggestionDiag,
  }, function(response)
    self:_collect_diagnostics(response)
  end)

  event_emitter:add_listener(constants.RequestCompletedEventName, function(response)
    self:_publish_diagnostics(response, notification)
  end)
end

return DiagnosticsService
