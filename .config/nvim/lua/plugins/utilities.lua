Is_Enabled = require("config.functions").is_enabled
Customize = require("config.customize")

return {
	-- {{{ plenary
	{
		"nvim-lua/plenary.nvim",
		lazy = true,
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ toggleterm.nvim
	{
		"akinsho/toggleterm.nvim",
		enabled = Is_Enabled("toggleterm.nvim"),
		keys = {
			{
				"<leader>Tg",
				function()
					Customize.toggleterm.lazygit()
				end,
			},
			{
				"<leader>TT",
				"<Cmd>:ToggleTerm<cr>",
			},
		},
		cmd = "ToggleTerm",
		version = "*",
		opts = {
			size = 13,
			open_mapping = [[<c-\>]],
			shade_filetypes = {},
			shade_terminals = true,
			shading_factor = "1",
			start_in_insert = true,
			persist_size = true,
			direction = "float",
		},
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ vim-fugitive
	{
		"tpope/vim-fugitive",
		dependencies = { "tpope/vim-rhubarb" },
		keys = {
			{ "<leader>g", "<cmd>G<cr>", desc = "open fugitive" },
		},
		enabled = Is_Enabled("vim-fugitive"),
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ vim-rhubarb
	{
		"tpope/vim-rhubarb",
		enabled = Is_Enabled("vim-rhubarb"),
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ vim-startuptime
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
		enabled = Is_Enabled("vim-startuptime"),
		init = function()
			vim.g.startuptime_tries = 10
		end,
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ zen-mode.nvim

	{
		"folke/zen-mode.nvim",
		enabled = Is_Enabled("zen-mode.nvim"),
		keys = {
			{
				"<leader>zm",
				function()
					require("zen-mode").toggle()
				end,
			},
		},
		opts = {
			window = {
				width = 0.7,
				height = 0.85,
				options = {
					colorcolumn = "",
					cursorcolumn = false,
					cursorline = false,
					number = true,
					relativenumber = true,
				},
			},
			plugins = {
				enabled = true,
				options = {
					ruler = false,
					showmd = true,
				},
				twilight = { enabled = false },
				gitsigns = { enabled = false },
				tmux = { enabled = false },
				alacritty = {
					enabled = true,
					font = "15",
				},
			},
		},
	},

	-- ----------------------------------------------------------------------- }}}
}
