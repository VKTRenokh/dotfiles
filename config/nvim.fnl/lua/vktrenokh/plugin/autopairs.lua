-- [nfnl] Compiled from autopairs.fnl by https://github.com/Olical/nfnl, do not edit.
local uu = require("vktrenokh.util")
return uu.tx("windwp/nvim-autopairs", {event = {"BufReadPost", "BufNewFile"}, config = true})
