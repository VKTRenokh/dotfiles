-- [nfnl] Compiled from fnl/config/util.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local fun = autoload("config.fun")
local _local_2_ = autoload("nfnl.core")
local update = _local_2_["update"]
local function _2bdocs(opts, to)
  local function _3_(desc)
    return (desc or to)
  end
  return update(opts, "desc", _3_)
end
local function keymap(modes, from, to, opts)
  local options = {silent = true, noremap = true}
  local opts0
  if (type(opts) == "table") then
    opts0 = vim.tbl_deep_extend("force", options, opts)
  elseif (type(opts) == "string") then
    opts0 = {desc = opts}
  else
    opts0 = nil
  end
  return vim.keymap.set(modes, from, to, _2bdocs(opts0, to))
end
local function vis_op_2b(op, args)
  local function _5_()
    return op({vim.api.nvim_buf_get_mark(0, "<"), vim.api.nvim_buf_get_mark(0, ">")}, args)
  end
  return _5_
end
local function _2bbuffer(opts, buffer)
  local function _6_(b)
    return (b or buffer)
  end
  return update(opts, "buffer", _6_)
end
local function bkset(modes, from, to, opts)
  local opts0
  if (type(opts) == "table") then
    opts0 = _2bbuffer(opts, 0)
  elseif (type(opts) == "number") then
    opts0 = {buffer = opts}
  elseif (type(opts) == "string") then
    opts0 = {desc = opts}
  else
    opts0 = {buffer = 0}
  end
  return vim.keymap.set(modes, from, to, _2bdocs(opts0, to))
end
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
    local function _8_(acc, n, v)
      acc[n] = v
      return acc
    end
    return fun.reduce(_8_, last(args), fun.zip(fun.range(1, len), fun.take((len - 1), args)))
  else
    return args
  end
end
local function autocmd(cmd, table)
  return vim.api.nvim_create_autocmd(cmd, table)
end
local function has(plugin)
  return (((require("lazy.core.config")).plugins)[plugin] ~= nil)
end
local function on_very_lazy(_function)
  local function _10_()
    return _function()
  end
  return autocmd("User", {pattern = "VeryLazy", callback = _10_})
end
local function on_attach(on_attach0)
  local function _11_(args)
    local buffer = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    return on_attach0(client, buffer)
  end
  return autocmd("LspAttach", {callback = _11_})
end
local function augroup(name)
  return vim.api.nvim_create_augroup(("vktr" .. name), {clear = true})
end
local function opts(name)
  local plugin = ((require("lazy.core.config")).plugins)[name]
  if not plugin then
    local ___antifnl_rtn_1___ = {}
    return ___antifnl_rtn_1___
  else
  end
  local Plugin = require("lazy.core.plugin")
  return Plugin.values(plugin, "opts", false)
end
return {opt = opt, colorscheme = colorscheme, g = g, opts = opts, keymap = keymap, autocmd = autocmd, has = has, ["vis-op+"] = vis_op_2b, bkset = bkset, ["on-very-lazy"] = on_very_lazy, ["on-attach"] = on_attach, augroup = augroup, tx = tx}
