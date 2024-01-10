-- [nfnl] Compiled from fnl/plugins/tokyonight.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local uu = autoload("config.util")
local function _2_(_, opts)
  local tokyonight = autoload("tokyonight")
  tokyonight.setup(opts)
  return uu.colorscheme("tokyonight")
end
return {uu.tx("folke/tokyonight.nvim", {lazy = true, opts = {transparent = true, style = "moon", styles = {sidebars = "transparent", floats = "transparent"}}, config = _2_, enabled = false})}
