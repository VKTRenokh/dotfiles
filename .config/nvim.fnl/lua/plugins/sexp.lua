-- [nfnl] Compiled from fnl/plugins/sexp.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("nfnl.core")
local some = _local_2_["some"]
local nvim = autoload("nvim")
local _local_3_ = autoload("config.util")
local autocmd = _local_3_["autocmd"]
local g = _local_3_["g"]
local tx = _local_3_["tx"]
local augroup = _local_3_["augroup"]
local lisps = {"clojure", "scheme", "lisp", "cl", "timl", "fennel", "janet"}
local function _4_()
  return g("parinfer_force_balance", true)
end
return tx("gpanders/nvim-parinfer", {ft = lisps, config = _4_})
