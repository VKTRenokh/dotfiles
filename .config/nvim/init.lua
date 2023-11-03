-- {{{ Core config
vim.loader.enable()

vim.g.mapleader = [[ ]]
vim.g.maplocalleader = [[,]]
-- }}}
require("config.bootstrap")
require("config.options")
require("config.keymaps")
require("config.lazy")
require("config.autocmds")
