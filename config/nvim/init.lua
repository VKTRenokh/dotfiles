require "vktr.base"
require "vktr.highlights"
require "vktr.plugins"
require "vktr.presence"
require "vktr.alpha"
require "vktr.bufferline"
require "vktr.nvimtree"
require "vktr.lualine"
require "options"
require "vktr.tressiter"
require "vktr.lsp"
require "emmet"
-- require "vktr.transparent"
require "vktr.lspsaga"
require "vktr.lspkind"
require "vktr.cmp"
require "vktr.tokyonight"

vim.cmd [[
  colorscheme tokyonight-moon
  highlight Normal guibg=none
  highlight NonText guibg=none
]]
