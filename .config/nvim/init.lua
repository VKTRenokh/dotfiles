-- {{{ Core config
vim.loader.enable()

vim.g.mapleader = [[ ]]
vim.g.maplocalleader = [[,]]
-- }}}

require("config.lazy")
require("config.keymaps")
require("config.autocmds")
require("config.options")
