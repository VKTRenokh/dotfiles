Customize = require("config.customize")
Icons = require("config.constants").icons
Is_Enabled = require("config.functions").is_enabled

return {
	-- {{{ catppuccin/nvim
	{
		"catppuccin/nvim",
		enabled = Is_Enabled("catppuccin"),
		lazy = true,
		name = "catppuccin",
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ colorbuddy
	{
		"tjdevries/colorbuddy.nvim",
		enabled = Is_Enabled("colorbuddy.nvim"),
		lazy = true,
		dependecies = {
			"svrana/neosolarized.nvim",
		},
		config = function()
			local ok, n = pcall(require, "neosolarized")
			local neo = Is_Enabled("neosolarized.nvim")
			if not neo then
				vim.cmd([[colorscheme tokyonight-moon]])
				return
			end

			if not ok then
				return
			end

			n.setup({
				comment_italics = true,
			})

			local cb = require("colorbuddy.init")
			local colors = cb.colors
			local Group = cb.Group
			-- local groups = cb.groups
			local styles = cb.styles

			Group.new("CursorLine", colors.none, colors.base03, styles.NONE, colors.base1)
			Group.new("CursorLineNr", colors.yellow, colors.none, styles.NONE, colors.base1)
			Group.new("Visual", colors.none, colors.base03, styles.reverse)

			-- local cError = groups.Error.fg
			-- local cInfo = groups.Information.fg
			-- local cWarn = groups.Warning.fg
			-- local cHint = groups.Hint.fg

			-- Group.new("DiagnosticVirtualTextError", cError, cError:dark():dark():dark():dark(), styles.NONE)
			-- Group.new("DiagnosticVirtualTextInfo", cInfo, cInfo:dark():dark():dark(), styles.NONE)
			-- Group.new("DiagnosticVirtualTextWarn", cWarn, cWarn:dark():dark():dark(), styles.NONE)
			-- Group.new("DiagnosticVirtualTextHint", cHint, cHint:dark():dark():dark(), styles.NONE)
			-- Group.new("DiagnosticUnderlineError", colors.none, colors.none, styles.undercurl, cError)
			-- Group.new("DiagnosticUnderlineWarn", colors.none, colors.none, styles.undercurl, cWarn)
			-- Group.new("DiagnosticUnderlineInfo", colors.none, colors.none, styles.undercurl, cInfo)
			-- Group.new("DiagnosticUnderlineHint", colors.none, colors.none, styles.undercurl, cHint)

			vim.cmd([[
      try
      colorscheme neosolarized
      catch /^Vim\%((\a\+)\)\=:E185/
      colorscheme tokyonight
      endtry
      ]])
		end,
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ gruvbox.nvim
	{
		"ellisonleao/gruvbox.nvim",
		enabled = Is_Enabled("gruvbox.nvim"),
		lazy = true,
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ neosolarized.nvim
	{
		"Tsuzat/NeoSolarized.nvim",
		enabled = Is_Enabled("neosolarized.nvim"),
		lazy = true,
		priority = 1000,
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ nvim-base16

	{
		"RRethy/nvim-base16",
		enabled = Is_Enabled("nvim-base16"),
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme base16-tokyo-night-terminal-storm]])
		end,
	},

	-- ----------------------------------------------------------------------- }}}
	-- {{{ nvim-transpartent

	{
		"xiyaowong/nvim-transparent",
		enabled = Is_Enabled("nvim-transparent"),
		event = "VimEnter",
		opts = {
			enable = true,
			"Comment",
			extra_gropus = {
				"CursorLine",
				"CursorLineNr",
				"CursorLineSign",
				"Folded",
				"LineNr",
				"Normal",
				"SignColumn",
				"GitSignsAdd",
				"GitSignsChange",
				"GitSignsDelete",
			},
			exclude = {
				"ColorColumn",
				"EndOfBuffer",
				"NonText",
			},
		},
		config = function()
			vim.cmd([[TransparentEnable]])
		end,
	},

	-- ----------------------------------------------------------------------- }}}
	-- {{{ nvim-treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		enabled = Is_Enabled("nvim-treesitter"),
		version = false,
		build = ":TSUpdate",
		keys = {
			{ "<c-space>", desc = "Increment selection" },
			{ "<bs>", desc = "Decrement selection", mode = "x" },
		},
		opts = {
			autopairs = { enable = true },
			autotag = { enable = true, disable = { "xml" } },
			autoinstall = true,
			context_commenting = { enable = true, enable_autocmd = false },
			highlight = {
				enable = true,
				disable = Constants.disabled.treesitter,
				additional_vim_regex_highlighting = true,
			},
			indent = { enable = true, disable = { "yml", "yaml" } },
			rainbow = {
				enable = true,
				extended_mode = true,
				max_file_lines = nil,
				colors = Constants.colors.rainbow,
			},
			disable = { "latex" },
			ensure_installed = Constants.ensure_installed.treesitter,
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = "<nop>",
					node_decremental = "<bs>",
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
		dependencies = {
			"windwp/nvim-ts-autotag",
			"mrjones2014/nvim-ts-rainbow",
			"JoosepAlviste/nvim-ts-context-commentstring",
			"nvim-treesitter/playground",
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				init = function()
					-- PERF: no need to load the plugin, if we only need its queries for mini.ai
					local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
					local opts = require("lazy.core.plugin").values(plugin, "opts", false)

					require("nvim-treesitter.configs").setup({
						playground = {
							enable = true,
							disable = {},
							updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
							persist_queries = false, -- Whether the query persists across vim sessions
							keybindings = {
								toggle_query_editor = "o",
								toggle_hl_groups = "i",
								toggle_injected_languages = "t",
								toggle_anonymous_nodes = "a",
								toggle_language_display = "I",
								focus_language = "f",
								unfocus_language = "F",
								update = "R",
								goto_node = "<cr>",
								show_help = "?",
							},
						},
					})
					local enabled = false
					if opts.textobjects then
						for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
							if opts.textobjects[mod] and opts.textobjects[mod].enable then
								enabled = true
								break
							end
						end
					end
					if not enabled then
						require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
					end
				end,
			},
		},
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ nvim-ts-rainbow

	{
		"mrjones2014/nvim-ts-rainbow",
		event = { "BufReadPost", "BufNewFile" },
		enabled = Is_Enabled("nvim-ts-rainbow"),
	},

	-- ----------------------------------------------------------------------- }}}
	-- {{{ tokyonight.nvim
	{
		"folke/tokyonight.nvim",
		enabled = Is_Enabled("tokyonight.nvim"),
		lazy = false,
		opts = {
			style = "moon",
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		},
		config = function(_, opts)
			require("tokyonight").setup(opts)

			vim.cmd([[colorscheme tokyonight]])
		end,
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ sxhkd-vim

	{
		"kovetskiy/sxhkd-vim",
		ft = "sxhkd",
		enabled = Is_Enabled("sxhkd-vim"),
	},

	-- ----------------------------------------------------------------------- }}}
	-- {{{ fluoromachine.nvim
	{
		"maxmx03/fluoromachine.nvim",
		opts = {
			theme = "retrowave",
			glow = false,
			brightness = 1,
		},
		lazy = false,
		config = function(_, opts)
			local fluoro = require("fluoromachine")

			fluoro.setup(opts)

			vim.cmd("colorscheme fluoromachine")
		end,
		enabled = Is_Enabled("fluoromachine.nvim"),
	},
	-- }}}
	-- {{{ nvim-colors-paramount
	{
		"VKTRenokh/nvim-colors-paramount",
		lazy = false,
		config = function()
			require("paramount").setup({
				transparent = true,
				italics = false,
			})

			vim.cmd("colorscheme paramount")
		end,

		enabled = Is_Enabled("vim-colors-paramount"),
	},
	-- }}}
	-- {{{ rose-pine.nvim
	{
		"rose-pine/neovim",
		lazy = false,
		enabled = Is_Enabled("rose-pine.nvim"),
		opts = {
			disable_background = true,
			group = {
				background = "none",
			},
		},
		config = function()
			local lp = require("rose-pine").setup({
				disable_background = true,
				disable_float_background = true,
				group = {
					background = "none",
				},
			})

			print("config call")

			vim.cmd("colorscheme rose-pine")
		end,
	},
	-- }}}
}
