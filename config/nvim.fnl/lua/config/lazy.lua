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

	checker = { enabled = true, notify = false},

  change_detection = {
    enabled = false,
    notify = false
  },

  ui = {
    border = "rounded"
  },

	perfomance = {
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
