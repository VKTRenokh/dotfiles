-- [nfnl] Compiled from startuptime.fnl by https://github.com/Olical/nfnl, do not edit.
local uu = require("vktrenokh.util")
local function _1_()
  return uu.g("startuptime_tries", 10)
end
return uu.tx("dstein64/vim-startuptime", {cmd = "StartupTime", init = _1_})
