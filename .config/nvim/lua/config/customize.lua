local Customize = {}
-- {{{ Customize documentation.
-- Customize table is a plugin name and true or false.  Using nvim_tree as the
-- example:
--   true - plug is loaded
--  false - plugin is NOT loaded.
--
-- This is a quick way to determine when a customization is interfering with
-- your expected behavior or two plugins are impacting with each other.

-- ------------------------------------------------------------------------- }}}
-- {{{ Disable or enable plugins
Customize = {
	plugins = {
		["alpha.nvim"] = { enabled = true },
		["bufferline.nvim"] = { enabled = true },
		["bullets.vim"] = { enabled = true },
		["catppuccin"] = { enabled = false },
		["comment.nvim"] = { enabled = true },
		["dressing"] = { enabled = true },
		["gitsigns.nvim"] = { enabled = true },
		["indent-blankline"] = { enabled = true },
		["lsp-config"] = { enabled = true },
		["lualine.nvim"] = { enabled = true },
		["markdown-preview.nvim"] = { enabled = true },
		["mason.nvim"] = { enabled = true },
		["mini-ai"] = { enabled = true },
		["mini-indentscope"] = { enabled = false },
		["mini-pairs"] = { enabled = true },
		["mini-surround"] = { enabled = true },
		["neoconf.nvim"] = { enabled = false },
		["neodev.nvim"] = { enabled = false },
		["noice.nvim"] = { enabled = true },
		["nui.nvim"] = { enabled = true },
		["nvim-autopairs"] = { enabled = true },
		["nvim-cmp"] = { enabled = true },
		["nvim-colorizer.lua"] = { enabled = true },
		["nvim-notify"] = { enabled = true },
		["nvim-treesitter"] = { enabled = true },
		["nvim-ts-rainbow2"] = { enabled = true },
		["nvim-ts-rainbow"] = { enabled = true },
		["nvim-web-devicons"] = { enabled = true },
		["popup.nvim"] = { enabled = true },
		["symbols-outline"] = { enabled = true },
		["telescope.nvim"] = { enabled = true },
		["telescope-file-browser.nvim"] = { enabled = true },
		["toggleterm.nvim"] = { enabled = true },
		["tokyonight.nvim"] = { enabled = true },
		["mini.pairs"] = { enabled = true },
		["trouble.nvim"] = { enabled = true },
		["vim-bbye"] = { enabled = false },
		["vim-fugitive"] = { enabled = true },
		["vim-illuminate"] = { enabled = false },
		["vim-rhubarb"] = { enabled = true },
		["virtcolumn.nvim"] = { enabled = true },
		["flash.nvim"] = { enabled = true },
		["conform.nvim"] = { enabled = true },
		["nvim-lint"] = { enabled = false },
		["incline.nvim"] = { enabled = true },
		["solarized-osaka.nvim"] = { enabled = false },
	},
}
-- }}}

return Customize
