function P(v)
  print(vim.inspect(v))
  return v
end

function RL(module)
  require("plenary.reload").reload_module(module)
  return require(module)
end
