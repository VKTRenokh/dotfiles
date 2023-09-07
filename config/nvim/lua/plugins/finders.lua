Constants = require("config.constants")
Customize = require("config.customize")
Is_Enabled = require("config.functions").is_enabled

return {
	-- {{{ Telescope
	{
		"nvim-telescope/telescope.nvim",
		enabled = Is_Enabled("telescope.nvim"),
		cmd = "Telescope",
		version = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
		},
		opts = {
			defaults = {
				layout_config = { prompt_position = "top" },
				layout_strategy = "horizontal",
				prompt_prefix = Constants.icons.ui.Telescope,
				sorting_strategy = "ascending",
				winblend = 0,
			},
			pickers = {
				colorscheme = { enable_preview = true },
			},
		},
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ Telescope file browser
	{
		"nvim-telescope/telescope-file-browser.nvim",
		enabled = Is_Enabled("telescope-file-browser.nvim"),
		dependencies = { "nvim-telescope/telescope.nvim" },
		--  cmd = "Telescope",
		config = function()
			local telescope = require("telescope")
			local fb_actions = require("telescope").extensions.file_browser.actions
			telescope.setup({
				extensions = {
					file_browser = {
						theme = "dropdown",
						-- disables netrw and use telescope-file-browser in its place
						hijack_netrw = true,
						mappings = {
							-- your custom insert mode mappings
							["i"] = {
								["<C-w>"] = function()
									vim.cmd("normal vbd")
								end,
							},
							["n"] = {
								-- your custom normal mode mappings
								["N"] = fb_actions.create,
								["h"] = fb_actions.goto_parent_dir,
								["/"] = function()
									vim.cmd("startinsert")
								end,
							},
						},
					},
				},
			})
			telescope.load_extension("file_browser")
		end,
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ oil.nvim
	{
		"stevearc/oil.nvim",
		keys = {
			{ "SF", "<cmd>lua require('oil').open_float()<cr>", desc = "Open floating oil" },
			{ "Sf", "<cmd>Oil<cr>", desc = "Open oil" },
		},
		opts = {
			columns = {
				"icon",
				"permissions",
			},
			buf_options = {
				buflisted = false,
				bufhidden = "hide",
			},
			keymaps = {
				["g?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["<C-s>"] = "actions.select_vsplit",
				["<C-h>"] = "actions.select_split",
				["<C-t>"] = "actions.select_tab",
				["<C-p>"] = "actions.preview",
				["q"] = "actions.close",
				["<Esc>"] = "actions.close",
				["<C-l>"] = "actions.refresh",
				["<leader>"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["`"] = "actions.cd",
				["~"] = "actions.tcd",
				["g."] = "actions.toggle_hidden",
			},
			win_options = {
				signcolumn = "yes",
			},
			float = {
				padding = 5,
				max_width = 0,
				max_height = 0,
				border = "rounded",
				win_options = {
					winblend = 10,
				},
				override = function(conf)
					return conf
				end,
			},
		},
		config = function(_, opts)
			require("oil").setup(opts)
		end,
		enabled = Is_Enabled("oil.nvim"),
	},
	-- }}}
}
