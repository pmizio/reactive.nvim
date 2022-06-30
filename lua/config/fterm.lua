local fn = vim.fn
local fterm = require "FTerm"
local ftutils = require "FTerm.utils"
local m = require "config.utils.map"

local ADDITIONAL_TERMINALS_BINDINGS = { "j", "k", "l" }

local DIMENSIONS = {
  height = 0.9,
  width = 0.9,
  y = 0,
}

fterm.setup {}

local terminals = {}

local function get_shell()
  if fn.has "macunix" or fn.has "unix" then
    return "/usr/local/bin/fish --login"
  end

  return vim.env.SHELL
end

for _, binding in ipairs(ADDITIONAL_TERMINALS_BINDINGS) do
  local term = fterm:new {
    cmd = get_shell(),
    dimensions = DIMENSIONS,
  }

  local function toggle()
    local closed_term = false

    for k, t in pairs(terminals) do
      if ftutils.is_win_valid(t.win) then
        t:close()
        closed_term = k
      end
    end

    if closed_term ~= binding then
      term:open()
    end
  end

  m.nmap("<leader>t" .. binding, toggle)
  m.tmap("<leader>t" .. binding, toggle)

  terminals[binding] = term
end

m.tmap("<ESC>", "<C-\\><C-n>")
m.tmap("<C-j>", "<DOWN>")
m.tmap("<C-k>", "<UP>")
m.tmap("<C-l>", "<RIGHT>")
m.tmap("<C-h>", "<LEFT>")
