local map = vim.keymap.set

local M = {}

function M.map(mode, lhs, rhs, options)
  map(mode, lhs, rhs, vim.tbl_extend("force", options or {}, { silent = true }))
end

function M.remap(mode, lhs, rhs, options)
  M.map(mode, lhs, rhs, vim.tbl_extend("force", options or {}, { remap = true }))
end

function M.nmap(...)
  M.map("n", ...)
end

function M.imap(...)
  M.map("i", ...)
end

function M.vmap(...)
  M.map("v", ...)
end

function M.xmap(...)
  M.map("x", ...)
end

function M.tmap(...)
  M.map("t", ...)
end

return M
