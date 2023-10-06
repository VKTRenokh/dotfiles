-- [nfnl] Compiled from fnl/plugins/autopairs.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local uu = autoload("config.util")
return uu.tx("windwp/nvim-autopairs", {event = {"BufReadPost", "BufNewFile"}, opts = {disable_filetype = {"clojure", "scheme", "lisp", "timl", "fennel", "janet", "racket"}}, config = true})
