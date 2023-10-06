-- [nfnl] Compiled from fnl/plugins/solarized.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("config.util")
local tx = _local_2_["tx"]
local colorscheme = _local_2_["colorscheme"]
local g = _local_2_["g"]
local function _3_()
  return colorscheme("zenbones")
end
return tx("mcchrish/zenbones.nvim", {priority = 1000, dependencies = "rktjmp/lush.nvim", config = _3_, lazy = false})
