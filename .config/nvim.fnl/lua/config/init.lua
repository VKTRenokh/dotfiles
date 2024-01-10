-- [nfnl] Compiled from fnl/config/init.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
vim.api.nvim_command("command! -nargs=1 -complete=help H help <args> | silent only")
local function _2_()
  return vim.cmd("if line(\"'\\\"\") > 1 && line(\"'\\\"\") <= line(\"$\") | exe \"normal! g'\\\"\" | endif")
end
vim.api.nvim_create_autocmd("BufReadPost", {pattern = "*", group = vim.api.nvim_create_augroup("LastPosition", {clear = true}), callback = _2_})
vim.o.autoread = true
local function _3_()
  return vim.highlight.on_yank({higroup = "IncSearch", timeout = 300})
end
vim.api.nvim_create_autocmd("TextYankPost", {group = vim.api.nvim_create_augroup("yank_highlight", {}), pattern = "*", callback = _3_})
return {}
