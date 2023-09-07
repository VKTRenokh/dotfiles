-- {{{ My personal Lazy setup.

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},

	defaults = {
		lazy = true,
		version = false,
	},

	install = { colorscheme = { "tokyonight" } },

	checker = { enabled = true },

	ui = {
		border = "rounded",
		title = "Test",
		title_pos = "center",
		pills = true,
	},

	perfomance = {
		cache = {
			enabled = true,
		},
		rtp = {
			disabled_plugins = {
				"gzip",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
-- }}}
