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

Customize = {
	-- {{{ Enable or disable plugins.

	plugins = {
		["aerial.nvim"] = { enabled = false },
		["alpha.nvim"] = { enabled = true },
		["bufferline.nvim"] = { enabled = true },
		["bullets.vim"] = { enabled = true },
		["catppuccin"] = { enabled = false },
		["colorbuddy.nvim"] = { enabled = false },
		["comment.nvim"] = { enabled = true },
		["dressing"] = { enabled = true },
		["gitsigns.nvim"] = { enabled = true },
		["gruvbox.nvim"] = { enabled = false },
		["indent-blankline"] = { enabled = true },
		["lsp-config"] = { enabled = true },
		["lualine.nvim"] = { enabled = true },
		["markdown-preview.nvim"] = { enabled = true },
		["mason.nvim"] = { enabled = true },
		["mini-ai"] = { enabled = true },
		["mini-comment"] = { enabled = false },
		["mini-indentscope"] = { enabled = true },
		["mini-pairs"] = { enabled = true },
		["mini-surround"] = { enabled = true },
		["neoconf.nvim"] = { enabled = false },
		["neodev.nvim"] = { enabled = false },
		["neosolarized.nvim"] = { enabled = false },
		["svrana/neosolarized.nvim"] = { enabled = false },
		["noice.nvim"] = { enabled = true },
		["nui.nvim"] = { enabled = true },
		["nvim-autopairs"] = { enabled = true },
		["nvim-base16"] = { enabled = false },
		["nvim-cmp"] = { enabled = true },
		["nvim-colorizer.lua"] = { enabled = true },
		["nvim-navic"] = { enabled = true },
		["nvim-notify"] = { enabled = true },
		["nvim-transparent"] = { enabled = true },
		["nvim-treesitter"] = { enabled = true },
		["nvim-ts-rainbow"] = { enabled = true },
		["nvim-web-devicons"] = { enabled = true },
		["popup.nvim"] = { enabled = true },
		["nekovim.nvim"] = { enabled = true },
		["symbols-outline"] = { enabled = true },
		["sxhkd-vim"] = { enabled = true },
		["telescope.nvim"] = { enabled = true },
		["telescope-file-browser.nvim"] = { enabled = true },
		["toggleterm.nvim"] = { enabled = true },
		["tokyonight.nvim"] = { enabled = true },
		["everforest.nvim"] = { enabled = false },
		["trouble.nvim"] = { enabled = true },
		["vim-bbye"] = { enabled = false },
		["vim-fugitive"] = { enabled = true },
		["vim-illuminate"] = { enabled = false },
		["vim-rhubarb"] = { enabled = true },
		["vim-startuptime"] = { enabled = true },
		["vim-visual-multi"] = { enabled = true },
		["virtcolumn.nvim"] = { enabled = true },
		["zen-mode.nvim"] = { enabled = true },
		["oil.nvim"] = { enabled = true },
		["flash.nvim"] = { enabled = true },
		["neoscroll.nvim"] = { enabled = false },
		["moonfly"] = { enabled = false },
		["conform.nvim"] = { enabled = true },
		["nvim-lint"] = { enabled = false },
		["incline.nvim"] = { enabled = false },
		["solarized-osaka.nvim"] = { enabled = false },
	},
}

Customize.toggleterm = {

	float = function()
		local Terminal = require("toggleterm.terminal").Terminal
		local t = Terminal:new({ direction = "float" })
		return t:toggle()
	end,

	lazygit = function()
		local Terminal = require("toggleterm.terminal").Terminal
		local t = Terminal:new({ cmd = "lazygit", direction = "float" })
		return t:toggle()
	end,

	lf = function()
		local Terminal = require("toggleterm.terminal").Terminal
		local t = Terminal:new({ cmd = "lf", direction = "float" })
		return t:toggle()
	end,
}

-- -------------------------------------------------------------------------}}}

return Customize
