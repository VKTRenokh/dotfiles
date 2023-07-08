Is_Enabled = require("config.functions").is_enabled

return {
	-- {{{ plenary
	{
		"nvim-lua/plenary.nvim",
		lazy = true,
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ presence.nvim
	{
		"andweeb/presence.nvim",
		lazy = false,
		enabled = Is_Enabled("presence.nvim"),
		config = function()
			require("presence").setup({
				neovim_image_text = "Tylko Edno W Glowie Ma", -- Text displayed when hovered over the Neovim image
				main_image = "neovim", -- Main image display (either "neovim" or "file")
				-- client_id = "793271441293967371", -- Use your own Discord application client id (not recommended)
				log_level = nil,
				debounce_timeout = 10, -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
				enable_line_number = false, -- Displays the current line number instead of the current project
				blacklist = {}, -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
				buttons = true, -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
				file_assets = {}, -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
				show_time = true, -- Show the timer
				editing_text = "Editing %s", -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
				file_explorer_text = "Browsing %s", -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
				git_commit_text = "Committing changes", -- Format string rendered when committing changes in git (either string or function(filename: string): string)
				plugin_manager_text = "Managing plugins", -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
				reading_text = "Reading %s", -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
				workspace_text = "Working on %s", -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
				line_number_text = "Line %s out of %s", -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
			})
		end,
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ toggleterm.nvim
	{
		"akinsho/toggleterm.nvim",
		enabled = Is_Enabled("toggleterm.nvim"),
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
			direction = "horizontal",
		},
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ vim-fugitive
	{
		"tpope/vim-fugitive",
		dependencies = { "tpope/vim-rhubarb" },
		event = "BufEnter",
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
	-- {{{ copium
	{
		"Exafunction/codeium.vim",
		enabled = Is_Enabled("codeium.nvim"),
		lazy = false,
		config = function()
			vim.keymap.set("i", "<C-g>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<c-h>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true })
		end,
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ git-conflicts.nvim
	{
		"akinsho/git-conflict.nvim",
		enabled = Is_Enabled("git-conflict.nvim"),
		lazy = false,
		opts = {
			default_mappings = true, -- disable buffer local mapping created by this plugin
			default_commands = true, -- disable commands created by this plugin
			disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
			highlights = {
				-- They must have background color, otherwise the default color will be used
				incoming = "DiffText",
				current = "DiffAdd",
			},
		},
		config = function(_, opts)
			require("git-conflict").setup(opts)
		end,
	},
	-- ----------------------------------------------------------------------- }}}
}
