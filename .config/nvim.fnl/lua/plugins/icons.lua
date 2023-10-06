-- [nfnl] Compiled from fnl/plugins/icons.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local uu = autoload("config.util")
local _local_2_ = autoload("config.constants")
local icons = _local_2_["icons"]
return uu.tx("nvim-tree/nvim-web-devicons", {opts = {override = icons.web_devicons}})
