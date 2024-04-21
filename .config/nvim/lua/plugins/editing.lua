return {
	-- {{{ bullets.nvim
	{
		"dkarter/bullets.vim",
		ft = "markdown",
		event = "LazyFile",
		init = function()
			vim.g.bullets_enabled_file_types = {
				"gitcommit",
				"markdown",
				"scratch",
				"text",
				"wiki",
			}
		end,
	},

	-- ----------------------------------------------------------------------- }}}
	-- {{{ Comment.nvim
	{
		"echasnovski/mini.comment",
		event = "LazyFile",
		opts = {
			options = {
				-- Function to compute custom 'commentstring' (optional)
				custom_commentstring = nil,

				-- Whether to ignore blank lines
				ignore_blank_line = false,

				-- Whether to recognize as comment only lines without indent
				start_of_line = false,

				-- Whether to ensure single space pad for comment parts
				pad_comment_parts = true,
			},

			-- Module mappings. Use `''` (empty string) to disable one.
			mappings = {
				-- Toggle comment (like `gcip` - comment inner paragraph) for both
				-- Normal and Visual modes
				comment = "gc",

				-- Toggle comment on current line
				comment_line = "gcc",

				-- Toggle comment on visual selection
				comment_visual = "gc",

				-- Define 'comment' textobject (like `dgc` - delete whole comment block)
				-- Works also in Visual mode if mapping differs from `comment_visual`
				textobject = "gc",
			},
		},
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ mini.pairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
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
	-- {{{ nvim-surround
	{
		"kylechui/nvim-surround",
		keys = {
			"<C-g>s",
			"<C-g>S",
			"ys",
			"yss",
			{ "yS", mode = { "n", "v" } },
			"ySS",
			{ "S", mode = { "n", "v" } },
			"gS",
			"ds",
			"cs",
			"cS",
		},
		config = function(_, opts)
			require("nvim-surround").setup(opts)
		end,
	},
	-- }}}
	-- {{{ refactoring.nvim
	{
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
	-- {{{ copium.nvim
	{
		"Exafunction/codeium.nvim",
		lazy = false,
		enabled = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({})
		end,
	},
	-- }}}
	-- {{{ nvim-spectre
	{
		"nvim-pack/nvim-spectre",
		build = false,
		cmd = "Spectre",
		opts = { open_cmd = "noswapfile vnew" },
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in Files (Spectre)" },
    },
	},
	-- }}}
	-- {{{ vim-illuminate
	{
		"RRethy/vim-illuminate",
		event = "LazyFile",
		config = function(_, opts)
			require("illuminate").configure(opts)
		end,
	},
	-- }}}
}
