-- {{{ Core config
vim.g.mapleader = [[ ]]
vim.g.maplocalleader = [[,]]

vim.loader.enable()
-- }}}
require("config.bootstrap")
require("config.options")
require("config.keymaps")
require("config.lazy")
require("config.autocmds")
