-- [nfnl] Compiled from fnl/plugins/colors.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("config.util")
local tx = _local_2_["tx"]
local colorscheme = _local_2_["colorscheme"]
local g = _local_2_["g"]
local function _3_()
  return colorscheme("zenbones")
end
local function _4_()
  return colorscheme("base16-tokyo-night-terminal-storm")
end
return {tx("mcchrish/zenbones.nvim", {lazy = true, enabled = true, priority = 1000, dependencies = "rktjmp/lush.nvim", config = _3_}), tx("VKTRenokh/nvim-base16", {priority = 1000, config = _4_, enabled = false, lazy = false}), tx("kovetskiy/sxhkd-vim", {ft = "sxhkd"})}
