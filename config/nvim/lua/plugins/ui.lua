Customize = require("config.customize")
Icons = require("config.constants").icons
Is_Enabled = require("config.functions").is_enabled

return {
	-- {{{ alpha.nvim
	{
		"goolord/alpha-nvim",
		enabled = Is_Enabled("alpha.nvim"),
		event = { "VimEnter", "BufReadPost", "BufNewFile" },
		opts = function()
			local dashboard = require("alpha.themes.dashboard")
			local logo = [[
       _______             ____   ____.__
       \      \   ____  ___\   \ /   /|__| _____
       /   |   \_/ __ \/  _ \   Y   / |  |/     \
      /    |    \  ___(  <_> )     /  |  |  Y Y  \
      \____|__  /\____ >____/ \___/   |__|__|_|  /
              \/                               \/
      ]]

			dashboard.section.header.val = vim.split(logo, "\n", {})
			dashboard.section.buttons.val = {
				dashboard.button("f", Icons.documents.Files .. " Find file", ":Telescope find_files <CR>"),
				dashboard.button("r", Icons.ui.History .. " Recent files", ":Telescope oldfiles <CR>"),
				dashboard.button("t", Icons.ui.List .. " Find text", ":Telescope live_grep <CR>"),
				dashboard.button(
					"c",
					Icons.ui.Gear .. " Config",
					":cd ~/.config/nvim/ | :e ~/.config/nvim/init.lua <CR>"
				),
				dashboard.button("u", Icons.ui.CloudDownload .. " Update", ":Lazy<CR>"),
				dashboard.button("q", Icons.ui.SignOut .. " Quit", ":qa<CR>"),
			}

			for _, button in ipairs(dashboard.section.buttons.val) do
				button.opts.hl = "AlphaButtons"
				button.opts.hl_shortcut = "AlphaShortcut"
			end

			dashboard.section.header.opts.hl = "AlphaHeader"
			dashboard.section.buttons.opts.hl = "AlphaButtons"
			dashboard.section.footer.opts.hl = "Type"
			dashboard.opts.opts.noautocmd = true
			return dashboard
		end,
		config = function(_, dashboard)
			-- close Lazy and re-open when the dashboard is ready
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					pattern = "AlphaReady",
					callback = function()
						require("lazy").show()
					end,
				})
			end
			require("alpha").setup(dashboard.opts)

			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyVimStarted",
				callback = function()
          local footerLogoTable = {
            [[⣇⣿⠘⣿⣿⣿⡿⡿⣟⣟⢟⢟⢝⠵⡝⣿⡿⢂⣼⣿⣷⣌⠩⡫⡻⣝⠹⢿⣿⣷]],
            [[⡆⣿⣆⠱⣝⡵⣝⢅⠙⣿⢕⢕⢕⢕⢝⣥⢒⠅⣿⣿⣿⡿⣳⣌⠪⡪⣡⢑⢝⣇]],
            [[⡆⣿⣿⣦⠹⣳⣳⣕⢅⠈⢗⢕⢕⢕⢕⢕⢈⢆⠟⠋⠉⠁⠉⠉⠁⠈⠼⢐⢕⢽]],
            [[⡗⢰⣶⣶⣦⣝⢝⢕⢕⠅⡆⢕⢕⢕⢕⢕⣴⠏⣠⡶⠛⡉⡉⡛⢶⣦⡀⠐⣕⢕]],
            [[⡝⡄⢻⢟⣿⣿⣷⣕⣕⣅⣿⣔⣕⣵⣵⣿⣿⢠⣿⢠⣮⡈⣌⠨⠅⠹⣷⡀⢱⢕]],
            [[⡝⡵⠟⠈⢀⣀⣀⡀⠉⢿⣿⣿⣿⣿⣿⣿⣿⣼⣿⢈⡋⠴⢿⡟⣡⡇⣿⡇⡀⢕]],
            [[⡝⠁⣠⣾⠟⡉⡉⡉⠻⣦⣻⣿⣿⣿⣿⣿⣿⣿⣿⣧⠸⣿⣦⣥⣿⡇⡿⣰⢗⢄]],
            [[⠁⢰⣿⡏⣴⣌⠈⣌⠡⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣬⣉⣉⣁⣄⢖⢕⢕⢕]],
            [[⡀⢻⣿⡇⢙⠁⠴⢿⡟⣡⡆⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣵⣵⣿]],
            [[⡻⣄⣻⣿⣌⠘⢿⣷⣥⣿⠇⣿⣿⣿⣿⣿⣿⠛⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
            [[⣷⢄⠻⣿⣟⠿⠦⠍⠉⣡⣾⣿⣿⣿⣿⣿⣿⢸⣿⣦⠙⣿⣿⣿⣿⣿⣿⣿⣿⠟]],
            [[⡕⡑⣑⣈⣻⢗⢟⢞⢝⣻⣿⣿⣿⣿⣿⣿⣿⠸⣿⠿⠃⣿⣿⣿⣿⣿⣿⡿⠁⣠]],
            [[⡝⡵⡈⢟⢕⢕⢕⢕⣵⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣿⣿⣿⣿⣿⠿⠋⣀⣈⠙]],
            [[⡝⡵⡕⡀⠑⠳⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⢉⡠⡲⡫⡪⡪⡣]],
          }

          dashboard.section.footer.val = footerLogoTable
					pcall(vim.cmd.AlphaRedraw)
				end,
			})
		end,
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ bufferline.nvim
	{
		"akinsho/nvim-bufferline.lua",
		-- event = "VeryLazy",
		enabled = Is_Enabled("bufferline.nvim"),
		keys = {
			{ "te", "<cmd>:tabedit<cr>", desc = "Tabs" },
		},
		opts = {
			options = {
				mode = "tabs",
				separator_style = "thin",
				show_buffer_close_icons = false,
				show_close_icon = false,
				color_icons = false,
				diagnostics = "nvim_lsp",
				always_show_bufferline = false,
				diagnostics_indicator = function(_, _, diag)
					local icons = Constants.icons.diagnostics
					local ret = (diag.error and icons.Error .. diag.error .. " " or "")
						.. (diag.warning and icons.Warning .. diag.warning or "")
					return vim.trim(ret)
				end,
				offsets = {
					{
						text_align = "left",
					},
				},
			},
			highlights = {
				background = {
					fg = "#616161",
				},
				buffer_selected = {
					fg = "#f1f1f1",
					bold = false,
					italic = true,
				},
			},
		},
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ dressing
	{
		"stevearc/dressing.nvim",
		enabled = Is_Enabled("dressing"),
		lazy = true,
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},

	-- ----------------------------------------------------------------------- }}}
	-- {{{ gitsigns.nvim
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		enabled = Is_Enabled("gitsigns.nvim"),
		opts = {
			signs = {
				add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
				change = {
					hl = "GitSignsChange",
					text = "▎",
					numhl = "GitSignsChangeNr",
					linehl = "GitSignsChangeLn",
				},
				delete = {
					hl = "GitSignsDelete",
					text = "契",
					numhl = "GitSignsDeleteNr",
					linehl = "GitSignsDeleteLn",
				},
				topdelete = {
					hl = "GitSignsDelete",
					text = "契",
					numhl = "GitSignsDeleteNr",
					linehl = "GitSignsDeleteLn",
				},
				changedelete = {
					hl = "GitSignsChange",
					text = "▎",
					numhl = "GitSignsChangeNr",
					linehl = "GitSignsChangeLn",
				},
			},
			on_attach = function(buffer)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
				end

        -- stylua: ignore start
        map('n', ']h', gs.next_hunk, 'Next Hunk')
        map('n', '[h', gs.prev_hunk, 'Prev Hunk')
        map({ 'n', 'v' }, '<leader>ghs', ':Gitsigns stage_hunk<CR>', 'Stage Hunk')
        map({ 'n', 'v' }, '<leader>ghr', ':Gitsigns reset_hunk<CR>', 'Reset Hunk')
        map('n', '<leader>ghS', gs.stage_buffer, 'Stage Buffer')
        map('n', '<leader>ghu', gs.undo_stage_hunk, 'Undo Stage Hunk')
        map('n', '<leader>ghR', gs.reset_buffer, 'Reset Buffer')
        map('n', '<leader>ghp', gs.preview_hunk, 'Preview Hunk')
        map('n', '<leader>ghb', function() gs.blame_line({ full = true }) end, 'Blame Line')
        map('n', '<leader>ghd', gs.diffthis, 'Diff This')
        map('n', '<leader>ghD', function() gs.diffthis('~') end, 'Diff This ~')
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'GitSigns Select Hunk')
			end,
			signcolumn = true,
			numhl = true,
			linehl = false,
			word_diff = false,
			watch_gitdir = {
				interval = 1000,
				follow_files = true,
			},
			attach_to_untracked = true,
			current_line_blame = false,
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol",
				delay = 1000,
				ignore_whitespace = false,
			},
			current_line_blame_formatter_opts = {
				relative_time = false,
			},
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil,
			max_file_length = 40000,
			preview_config = {
				border = "rounded",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
			yadm = {
				enable = false,
			},
		},
	},

	-- ----------------------------------------------------------------------- }}}
	-- {{{ indent-blankline.nvim
	{
		"lukas-reineke/indent-blankline.nvim",
		enabled = Is_Enabled("indent-blankline"),
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			char = "│",
			filetype_exclude = { "help", "alpha", "dashboard", "Trouble", "lazy" },
			show_trailing_blankline_indent = false,
			show_current_context = false,
			--	show_current_context_start = true,
			--  use_treesitter = true,
		},
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ lualine.nvim
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		enabled = Is_Enabled("lualine.nvim"),
		opts = function(_, opts)
			local hide_in_width = function()
				return vim.fn.winwidth(0) > 80
			end

			local diagnostics = {
				"diagnostics",
				sources = { "nvim_diagnostic" },
				sections = { "error", "warn" },
				symbols = { error = " ", warn = " " },
				colored = true,
				update_in_insert = false,
				always_visible = true,
			}

			local diff = {
				"diff",
				colored = false,
				symbols = { added = " ", modified = " ", removed = " " },
				cond = hide_in_width,
			}

			local mode = {
				"mode",
				fmt = function(str)
					return string.lower(str)
				end,
			}

			local filetype = {
				"filetype",
				icons_enabled = true,
				icon = nil,
				colored = true,
			}

			local branch = {
				"branch",
				icons_enabled = true,
				icon = "שׂ",
			}

			local location = {
				"location",
				padding = 0,
			}

			local progress = function()
				local current_line = vim.fn.line(".")
				local total_lines = vim.fn.line("$")
				local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
				local line_ratio = current_line / total_lines
				local index = math.ceil(line_ratio * #chars)
				return chars[index]
			end

			local spaces = function()
				return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
			end

			opts.options = {
				icons_enabled = true,
				-- theme = "solarized_dark",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disable_filetypes = { "dashboard", "NvimTree", "Outline" },
				--  disabled_filetypes = {
				--    statusline = {},
				--    winbar = {},
				--  },
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			}

			opts.sections = {
				lualine_a = { mode },
				lualine_b = { branch },
				lualine_c = { {
					"filename",
					file_status = true,
					path = 0,
				} },
				lualine_x = { diagnostics, diff, spaces, "encoding", filetype },
				lualine_y = { progress },
				lualine_z = { location },
			}

			opts.inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { {
					"filename",
					file_status = true,
					path = 1,
				} },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			}

			opts.tabline = {}
			opts.winbar = {}
			opts.inactive_winbar = {}
			opts.extensions = { "fugitive" }
		end,
		config = function(_, opts)
			require("lualine").setup(opts)
			vim.cmd([[ set laststatus=3 ]])
		end,
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ mini.indentscope
	{
		"echasnovski/mini.indentscope",
		enabled = Is_Enabled("mini-indentscope"),
		version = false, -- wait till new 0.7.0 release to put it back on semver
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			draw = {
				delay = 0,
				animation = nil,
			},
			symbol = "│",
			options = { try_as_border = true },
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "help", "alpha", "dashboard", "Trouble", "lazy", "mason" },
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
		config = function(_, opts)
			local mis = require("mini.indentscope")
			opts.draw.animation = mis.gen_animation.none()
			mis.setup(opts)
		end,
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ noice.nvim
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		enabled = Is_Enabled("noice.nvim"),
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = false,
					["cmp.entry.get_documentation"] = false,
				},
			},
			presets = {
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = true,
			},
			cmdline_popup = {
				views = {
					row = "50%",
					col = "50%",
				},
				win_options = {
					winhighlight = "NormalFloat:NormalFloat, FloatBoarder:FloatBorder",
				},
			},
		},
	},
	-- --------------------------------------------------- }}}
	-- {{{ nui.nvim

	{
		"MunifTanjim/nui.nvim",
		enabled = Is_Enabled("nui.nvim"),
		lazy = true,
	},

	-- ----------------------------------------------------------------------- }}}
	-- {{{ nvim-colorizer

	{
		"NvChad/nvim-colorizer.lua",
		enabled = Is_Enabled("nvim-colorizer.lua"),
		event = "VeryLazy",
		config = true,
	},

	-- ----------------------------------------------------------------------- }}}
	-- {{{ nvim-notify
	{
		"rcarriga/nvim-notify",
		enabled = Is_Enabled("nvim-notify"),
		opts = {
			background_colour = "#1a1b26",
			level = 3,
			render = "compact",
			stages = "static",
			timeout = 3000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
		},
		init = function()
			-- when noice is not enabled, install notify on VeryLazy
			local Util = require("config.functions")
			if not Util.has("noice.nvim") then
				Util.on_very_lazy(function()
					vim.notify = require("notify")
				end)
			end
		end,
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ nvim-web-devicons

	{
		"nvim-tree/nvim-web-devicons",
		enabled = Is_Enabled("nvim-web-devicons"),
		lazy = true,
		opts = {
			override = Constants.icons.web_devicons,
		},
	},

	-------------------------------------------------------------------------- }}}}
}
