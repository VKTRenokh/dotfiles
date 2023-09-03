-- [nfnl] Compiled from util.fnl by https://github.com/Olical/nfnl, do not edit.
local fun = require("vktrenokh.vendor.fun")
local function opt(key, value)
  vim.opt[key] = value
  return nil
end
local function g(key, value)
  vim.g[key] = value
  return nil
end
local function last(xs)
  return fun.nth(fun.length(xs), xs)
end
local function colorscheme(name)
  return vim.cmd(("colorscheme " .. name))
end
local function tx(...)
  local args = {...}
  local len = fun.length(args)
  if ("table" == type(last(args))) then
    local function _1_(acc, n, v)
      acc[n] = v
      return acc
    end
    return fun.reduce(_1_, last(args), fun.zip(fun.range(1, len), fun.take((len - 1), args)))
  else
    return args
  end
end
local function keymap(mode, key, command)
  return vim.api.nvim_set_keymap(mode, key, command, {silent = true, noremap = true})
end
local function autocmd(cmd, table)
  return vim.api.nvim_create_autocmd(cmd, table)
end
return {opt = opt, colorscheme = colorscheme, g = g, keymap = keymap, autocmd = autocmd, tx = tx}
