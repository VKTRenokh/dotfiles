-- [nfnl] Compiled from fnl/plugins/conjure.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local uu = autoload("config.util")
local function _2_(_, opts)
  local cjmain = autoload("conjure.main")
  local cjmap = autoload("conjure.mapping")
  cjmain.main()
  cjmap["on-filetype"]()
  return nil
end
local function _3_()
  return uu.g("conjure#debug", true)
end
return uu.tx("Olical/conjure", {ft = {"clojure", "scheme", "lisp", "cl", "timl", "fennel", "janet"}, config = _2_, init = _3_})
