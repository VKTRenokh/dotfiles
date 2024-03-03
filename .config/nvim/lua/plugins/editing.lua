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
		enabled = Is_Enabled("flash.nvim"),
	},
	-- }}}
	-- {{{ mini.surround
	{
		"VKTRenokh/mini.surround",
		keys = {
			{ "sa", mode = { "n", "x", "v" } }, -- Add surrounding in Normal and Visual modes
			{ "sd", mode = { "n", "x", "v" } }, -- Delete surrounding
			{ "sh", mode = { "n", "x", "v" } }, -- Highlight surrounding
			{ "sr", mode = { "n", "x", "v" } }, -- Replace surrounding
			{ "sn", mode = { "n", "x", "v" } }, -- Update `n_lines`
		},
		opts = {
			{
				-- Add custom surroundings to be used on top of builtin ones. For more
				-- information with examples, see `:h MiniSurround.config`.
				custom_surroundings = nil,

				-- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
				highlight_duration = 500,

				-- Module mappings. Use `''` (empty string) to disable one.
				mappings = {
					add = "sa", -- Add surrounding in Normal and Visual modes
					delete = "sd", -- Delete surrounding
					highlight = "sh", -- Highlight surrounding
					replace = "sr", -- Replace surrounding
					update_n_lines = "sn", -- Update `n_lines`
					find = "su", -- Find surrounding (to the right)
					find_left = "sU", -- Find surrounding (to the left)

					suffix_last = "l", -- Suffix to search with "prev" method
					suffix_next = "n", -- Suffix to search with "next" method
				},

				-- Number of lines within which surrounding is searched
				n_lines = 20,

				-- Whether to respect selection type:
				-- - Place surroundings on separate lines in linewise mode.
				-- - Place surroundings on each line in blockwise mode.
				respect_selection_type = false,

				-- How to search for surrounding (first inside current line, then inside
				-- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
				-- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
				-- see `:h MiniSurround.config`.
				search_method = "cover",

				-- Whether to disable showing non-error feedback
				silent = false,
			},
		},
		config = true,
		enabled = Is_Enabled("mini-surround"),
	},
	-- }}}
	{ -- {{{ refactoring.nvim
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		keys = {
			{
				"<leader>rn",
				function()
					require("refactoring").select_refactor({
						show_success_message = true,
					})
				end,
				mode = "v",
				noremap = true,
				silent = true,
				expr = false,
			},
		},
		opts = {},
		config = function(_, opts)
			require("refactoring").setup(opts)
		end,
	}, -- }}}
}
