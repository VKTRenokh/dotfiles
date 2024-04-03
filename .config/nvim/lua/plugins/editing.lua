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
		"echasnovski/mini.comment",
		event = { "BufReadPost", "BufNewFile" },
		enabled = Is_Enabled("comment.nvim"),
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
		"echasnovski/mini.pairs",
		event = { "BufReadPost", "BufNewFile" },
		enabled = Is_Enabled("mini.pairs"),
		opts = {},
		keys = {
			{
				"<leader>up",
				function()
					local Util = require("lazy.core.util")
					vim.g.minipairs_disable = not vim.g.minipairs_disable
					if vim.g.minipairs_disable then
						Util.warn("Disabled auto pairs", { title = "Option" })
					else
						Util.info("Enabled auto pairs", { title = "Option" })
					end
				end,
				desc = "Toggle auto pairs",
			},
		},
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
		enabled = Is_Enabled("mini-surround"),
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
	-- {{{ vim-illuminate
	{
		"RRethy/vim-illuminate",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			delay = 200,
			large_file_cutoff = 2000,
			large_file_overrides = {
				providers = { "lsp" },
			},
		},
		config = function(_, opts)
			require("illuminate").configure(opts)

			local function map(key, dir, buffer)
				vim.keymap.set("n", key, function()
					require("illuminate")["goto_" .. dir .. "_reference"](false)
				end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
			end

			map("]]", "next")
			map("[[", "prev")

			-- also set it after loading ftplugins, since a lot overwrite [[ and ]]
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					local buffer = vim.api.nvim_get_current_buf()
					map("]]", "next", buffer)
					map("[[", "prev", buffer)
				end,
			})
		end,
		keys = {
			{ "]]", desc = "Next Reference" },
			{ "[[", desc = "Prev Reference" },
		},
	},
	-- }}}
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
}
