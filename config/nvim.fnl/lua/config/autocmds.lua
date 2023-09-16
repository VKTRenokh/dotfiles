-- [nfnl] Compiled from fnl/config/autocmds.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("config.util")
local autocmd = _local_2_["autocmd"]
local augroup = _local_2_["augroup"]
local keymap = _local_2_["keymap"]
local function _3_()
  vim.cmd("highlight Folded guibg=NONE")
  vim.cmd("highlight ColorColumn guibg=#292d42")
  vim.cmd("highlight LineNr guifg=#e0af68")
  vim.cmd("highlight LineNrAbove guifg=#787c99")
  return vim.cmd("highlight LineNrBelow guifg=#787c99")
end
autocmd("BufEnter", {callback = _3_})
local function _4_(event)
  vim.bo[event.buf]["buflisted"] = false
  return keymap("n", "q", "<cmd>close<cr>", {buffer = event.buf, silent = true})
end
autocmd("filetype", {pattern = {"alpha", "PlenaryTestPopup", "dashboard", "fugitive", "help", "lspinfo", "man", "mason", "notify", "qf", "spectre_panel", "startuptime", "tsplayground"}, callback = _4_})
local function _5_()
  vim.cmd("setlocal formatoptions+=c ")
  vim.cmd("setlocal formatoptions+=j ")
  vim.cmd("setlocal formatoptions+=n ")
  vim.cmd("setlocal formatoptions+=q ")
  vim.cmd("setlocal formatoptions+=r ")
  vim.cmd("setlocal formatoptions-=2 ")
  vim.cmd("setlocal formatoptions-=a ")
  vim.cmd("setlocal formatoptions-=o ")
  return vim.cmd("setlocal formatoptions-=t ")
end
autocmd("BufEnter", {callback = _5_})
local function _6_()
  local mark = vim.api.nvim_buf_get_mark(0, "\"")
  local lcount = vim.api.nvim_buf_line_count(0)
  if ((mark[1] > 0) and (mark[1] <= lcount)) then
    return pcall(vim.api.nvim_win_set_cursor, 0, mark)
  else
    return nil
  end
end
autocmd("BufReadPost", {callback = _6_})
do
  local highlight_group = augroup("YankHighlight", {clear = true})
  local function _8_()
    return vim.highlight.on_yank()
  end
  autocmd("TextYankPost", {callback = _8_, group = highlight_group, pattern = "*"})
end
do
  local json_group = augroup("Json", {clear = true})
  autocmd({"BufRead", "BufNewFile"}, {command = "syntax match Comment +\\/\\/.\\+$+", group = json_group, pattern = "*.json"})
end
autocmd({"FocusGained", "TermClose", "TermLeave"}, {command = "checktime"})
local function _9_()
  return vim.cmd("tabdo wincmd =")
end
autocmd("VimResized", {callback = _9_})
local function _10_()
  vim.opt_local.spell = true
  return nil
end
autocmd("FileType", {pattern = {"gitcommit", "markdown", "wiki"}, callback = _10_})
local whitespace_group = augroup("WhiteSpace", {clear = true})
return autocmd("BufWritePre", {command = "%s/\\s\\+$//e", group = whitespace_group})
