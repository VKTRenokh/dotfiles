-- [nfnl] Compiled from fnl/plugins/editing.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("config.util")
local tx = _local_2_["tx"]
local keymap = _local_2_["keymap"]
local english = "asdfghjklqwertyuiopzxcvbnm"
local function _3_()
  return (require("flash")).jump()
end
return {tx("numToStr/Comment.nvim", {keys = {{"gcc", ""}, {"gbc", ""}, {"gc", ""}, {"gc0", ""}, {"gco", ""}, {"gcA", ""}}, opts = {padding = true, sticky = true, ignore = nil, toggler = {line = "gcc", block = "gbc"}, opleader = {line = "gc", block = "gbc"}, extra = {above = "gc0", below = "gco", eol = "gcA"}, mappings = {basic = true, extra = true}, pre_hook = nil, post_hook = nil}}), tx("mg979/vim-visual-multi", {keys = {{"<c-down>", desc = "vim visual multi add new cursor below"}, {"<C-n>", desc = "Vim visual multi select next word"}, {"<c-down>", desc = "vim visual multi add new cursor above"}}}), tx("folke/flash.nvim", {keys = {{"<leader>/", _3_, mode = {"n", "x", "o"}}}, opts = {lables = english, modes = {char = {enabled = false}, search = {enabled = true, search = {enabled = true, incremental = true}}, treesitter = {enabled = false}}, label = {rainbow = {shade = 5, enabled = false}, before = true, style = "inline", uppercase = false, after = false}}, config = true})}
