-- [nfnl] Compiled from fnl/plugins/ui.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("config.util")
local tx = _local_2_["tx"]
local function _3_()
  return (require("todo-comments")).jump_next()
end
local function _4_()
  return (require("todo-comments")).jump_prev()
end
local function _5_()
  return vim.fn()["mkdp#util#install"]()
end
local function _6_()
  local function _7_(...)
    local args = {...}
    do end (autoload("lazy")).load({plugins = {"dressing.nvim"}})
    return vim.ui.select(args)
  end
  vim.ui.select = _7_
  local function _8_(...)
    local args = {...}
    do end (autoload("lazy")).load({plugins = {"dressing.nvim"}})
    return vim.ui.input(args)
  end
  vim.ui.input = _8_
  return nil
end
return {tx("folke/todo-comments.nvim", {cmd = {"TodoTrouble", "TodoTelescope"}, event = {"BufReadPost", "BufNewFile"}, config = true, keys = {{"]t", _3_}, {"[t", _4_}, {"<leader>xt", "<cmd>TodoTrouble<cr>"}, {"<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>"}, {";td", "<cmd>TodoTelescope<cr>"}, {";tD", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>"}}}), tx("folke/trouble.nvim", {keys = {{"<leader>LR", "<cmd>TroubleToggle lsp_references<cr>", desc = "open trouble with lsp references"}, {"<leader>Ld", "<cmd>TroubleTOggle lsp_document_symbols<cr>", desc = "open trouble with lsp symbols"}}, opts = {use_diagnostic_signs = true}}), tx("iamcco/markdown-preview.nvim", {ft = "markdown", config = _5_}), tx("lewis6991/gitsigns.nvim", {event = "BufReadPre", opts = {signs = {add = {text = "\226\150\142"}, change = {text = "\226\150\142"}, delete = {text = "\239\164\137"}, topdelete = {text = "\239\164\137"}, changedelete = {text = "\226\150\142"}, untracked = {text = "\226\150\142"}}, signcolumn = true, numhl = true, watch_gitdir = {interval = 1000, follow_files = true}, attach_to_untracked = true, current_line_blame = true, current_line_blame_opts = {virt_text = true, virt_text_pos = "eol", delay = 1000, ignore_whitespace = false}, current_line_blame_formatter_opts = {relative_time = false}, sign_priority = 6, update_debounce = 100, max_file_length = 40000, preview_config = {border = "rounded", style = "minimal", relative = "cursor", row = 0, col = 1}, yadm = {enable = false}, linehl = false, word_diff = false}}), tx("stevearc/dressing.nvim", {init = _6_})}
