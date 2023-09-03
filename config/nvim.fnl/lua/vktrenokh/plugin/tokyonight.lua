-- [nfnl] Compiled from tokyonight.fnl by https://github.com/Olical/nfnl, do not edit.
local uu = require("vktrenokh.util")
local function _1_(_, opts)
  local tokyonight = require("tokyonight")
  tokyonight.setup(opts)
  return uu.colorscheme("tokyonight")
end
return {uu.tx("folke/tokyonight.nvim", {opts = {transparent = true, style = "moon", styles = {sidebars = "transparent", floats = "transparent"}}, config = _1_, lazy = false})}
