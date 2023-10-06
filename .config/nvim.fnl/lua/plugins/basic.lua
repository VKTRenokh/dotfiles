-- [nfnl] Compiled from fnl/plugins/basic.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("config.util")
local tx = _local_2_["tx"]
return {tx("kovetskiy/sxhkd-vim", {ft = "sxhkd"}), tx("dkarter/bullets.vim", {ft = "markdown"}), tx("NvChad/nvim-colorizer.lua", {event = {"BufReadPost", "BufNewFile"}, config = true}), tx("nvim-lua/popup.nvim", {event = "VimEnter"}), tx("xiyaowong/virtcolumn.nvim", {event = {"BufReadPost", "BufNewFile"}}), tx("nvim-lua/plenary.nvim")}
