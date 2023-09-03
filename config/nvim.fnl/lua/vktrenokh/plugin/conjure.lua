-- [nfnl] Compiled from conjure.fnl by https://github.com/Olical/nfnl, do not edit.
local uu = require("vktrenokh.util")
local function _1_(_, opts)
  local cjmain = require("conjure.main")
  local cjmap = require("conjure.mapping")
  cjmain.main()
  cjmap["on-filetype"]()
  return nil
end
local function _2_()
  return uu.g("conjure#debug", true)
end
return uu.tx("Olical/conjure", {ft = {"clojure", "fennel", "python"}, config = _1_, init = _2_})
