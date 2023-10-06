-- [nfnl] Compiled from init.fnl by https://github.com/Olical/nfnl, do not edit.
vim.g["mapleader"] = " "
vim.g["maplocalleader"] = " "
require("config.bootstrap")
require("config.lazy")
require("config.autocmds")
require("config.options")
return require("config.keymaps")
