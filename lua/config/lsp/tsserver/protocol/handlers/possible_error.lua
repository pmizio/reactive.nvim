---@param command string
---@param arguments table
return function(command, arguments)
  assert(arguments.success, command .. " failed in tsserver!")
end
