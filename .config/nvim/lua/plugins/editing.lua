Is_Enabled = require("config.functions").is_enabled

return {
	-- {{{ bullets.nvim

	{
		"dkarter/bullets.vim",
		ft = "markdown",
		enabled = Is_Enabled("bullets.vim"),
	},

	-- ----------------------------------------------------------------------- }}}
	-- {{{ Comment.nvim
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPost", "BufNewFile" },
		enabled = Is_Enabled("comment.nvim"),
		opts = {
			padding = true,
			sticky = true,
			ignore = nil,
			toggler = {
				line = "gcc",
				block = "gbc",
			},
			opleader = {
				line = "gc",
				block = "gb",
			},
			extra = {
				above = "gc0",
				below = "gco",
				eol = "gcA",
			},
			mappings = {
				basic = true,
				extra = true,
			},
			pre_hook = nil,
			post_hook = nil,
		},

		config = function(_, opts)
			require("Comment").setup(opts)
		end,
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ nvim-autopairs
	{
		"windwp/nvim-autopairs",
		event = { "BufReadPost", "BufNewFile" },
		enabled = Is_Enabled("nvim-autopairs"),
		config = true,
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ vim-visual-multi
	{
		"mg979/vim-visual-multi",
		event = { "BufReadPost", "BufNewFile" },
		enabled = Is_Enabled("vim-visual-multi"),
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ flash.nvim
	{
		"folke/flash.nvim",
		keys = {
			{
				"<leader>/",
				function()
					(require("flash")).jump()
				end,
				mode = { "n", "x", "o" },
			},
		},
		opts = {
			lables = "asdfghjklqwertyuiopzxcvbnm",
			modes = {
				char = { enabled = false },
				search = {
					enabled = true,
					search = {
						enabled = true,
						incremental = true,
					},
				},
				treesitter = { enabled = false },
			},
			label = {
				uppercase = false,
				rainbow = { enalbed = false, shade = 5 },
				after = false,
				before = true,
				style = "inline",
			},
		},
		config = true,
	},
	-- }}}
}
