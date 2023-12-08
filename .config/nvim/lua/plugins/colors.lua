Customize = require("config.customize")
Icons = require("config.constants").icons
Is_Enabled = require("config.functions").is_enabled

return {
	-- {{{ catppuccin/nvim
	{
		"catppuccin/nvim",
		enabled = Is_Enabled("catppuccin"),
		lazy = false,
		name = "catppuccin",
		config = function(_, opts)
			require("catppuccin").setup(opts)

			vim.cmd.colorscheme("catppuccin")
		end,
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ colorbuddy
	{
		"tjdevries/colorbuddy.nvim",
		enabled = Is_Enabled("colorbuddy.nvim"),
		lazy = false,
		dependencies = {
			"svrana/neosolarized.nvim",
		},
		config = function()
			local n = require("neosolarized")
			local neo = Is_Enabled("svrana/neosolarized.nvim")
			if not neo then
				vim.cmd([[colorscheme tokyonight]])
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

			local cError = groups.Error.fg
			local cInfo = groups.Information.fg
			local cWarn = groups.Warning.fg
			local cHint = groups.Hint.fg

			Group.new("DiagnosticVirtualTextError", cError, cError:dark():dark():dark():dark(), styles.NONE)
			Group.new("DiagnosticVirtualTextInfo", cInfo, cInfo:dark():dark():dark(), styles.NONE)
			Group.new("DiagnosticVirtualTextWarn", cWarn, cWarn:dark():dark():dark(), styles.NONE)
			Group.new("DiagnosticVirtualTextHint", cHint, cHint:dark():dark():dark(), styles.NONE)
			Group.new("DiagnosticUnderlineError", colors.none, colors.none, styles.undercurl, cError)
			Group.new("DiagnosticUnderlineWarn", colors.none, colors.none, styles.undercurl, cWarn)
			Group.new("DiagnosticUnderlineInfo", colors.none, colors.none, styles.undercurl, cInfo)
			Group.new("DiagnosticUnderlineHint", colors.none, colors.none, styles.undercurl, cHint)

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
		"VKTRenokh/nvim-base16",
		enabled = Is_Enabled("nvim-base16"),
		lazy = false,
		priority = 1000,

		config = function()
			vim.cmd([[colorscheme base16-tokyo-night-terminal-storm]])
			vim.cmd([[hi CmpItemAbr guibg=NONE]])
		end,
	},

	-- ----------------------------------------------------------------------- }}}
	-- {{{ nvim-transpartent

	{
		"xiyaowong/nvim-transparent",
		enabled = Is_Enabled("nvim-transparent"),
		event = "VimEnter",
		opts = {
			"Comment",
			extra_gropus = {
				"CursorLine",
				"CursorLineNr",
				"CursorLineSign",
				"Folded",
				"LineNr",
				"Normal",
				"SignColumn",
				"NotifyBackground",
			},
			exclude_groups = {
				"ColorColumn",
				"EndOfBuffer",
				"NonText",
				"LazyNormal",
			},
		},
		config = true,
	},

	-- ----------------------------------------------------------------------- }}}
	-- {{{ nvim-treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		enabled = Is_Enabled("nvim-treesitter"),
		build = ":TSUpdate",
		-- version = "v0.9.1",
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
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
					selection_modes = {},
					include_surrounding_whitespace = true,
				},
			},
			indent = { enable = true, disable = { "yml", "yaml" } },
			rainbow = {
				enable = true,
				extended_mode = false,
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
			{
				"JoosepAlviste/nvim-ts-context-commentstring",
				config = function(_, opts)
					require("ts_context_commentstring").setup(opts)

					vim.g.skip_ts_context_commentstring_module = true
				end,
			},
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				init = function()
					-- PERF: no need to load the plugin, if we only need its queries for mini.ai
					local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
					local opts = require("lazy.core.plugin").values(plugin, "opts", false)
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
			transparent = true,
			style = "night",
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
			-- on_colors = function(colors)
			-- 	local bg_dark = "#011423"
			-- 	local bg_highlight = "#143652"
			-- 	local bg_search = "#0A64AC"
			-- 	local bg_visual = "#275378"
			-- 	local fg = "#CBE0F0"
			-- 	local fg_dark = "#B4D0E9"
			-- 	local fg_gutter = "#627E97"
			-- 	local border = "#547998"
			--
			-- 	colors.bg_dark = bg_dark
			-- 	colors.bg_highlight = bg_highlight
			-- 	colors.bg_popup = bg_dark
			-- 	colors.bg_search = bg_search
			-- 	colors.bg_sidebar = bg_dark
			-- 	colors.bg_statusline = bg_dark
			-- 	colors.bg_visual = bg_visual
			-- 	colors.border = border
			-- 	colors.fg = fg
			-- 	colors.fg_dark = fg_dark
			-- 	colors.fg_float = fg
			-- 	colors.fg_gutter = fg_gutter
			-- 	colors.fg_sidebar = fg_dark
			-- end,
		},
		config = function(_, opts)
			require("tokyonight").setup(opts)

			vim.cmd.colorscheme("tokyonight")
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
	-- {{{ everforest.nvim
	{
		"neanias/everforest-nvim",
		priority = 1000,
		opts = {
			transparent = true,
		},
		lazy = false,
		config = function(_, opts)
			require("everforest").setup(opts)

			vim.cmd.colorscheme([[everforest]])
		end,
		enabled = Is_Enabled("everforest.nvim"),
	},
	-- }}}
	-- {{{ solarized-osaka.nvim
	{
		"craftzdog/solarized-osaka.nvim",
		priority = 1000,
		opts = {
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
			-- on_highlights = function(c)
			-- 	c.NavicIconsFile = { fg = c.fg, bg = "NONE" }
			-- 	c.NavicIconsModule = { fg = c.yellow, bg = "NONE" }
			-- 	c.NavicIconsNamespace = { fg = c.fg, bg = "NONE" }
			-- 	c.NavicIconsPackage = { fg = c.fg, bg = "NONE" }
			-- 	c.NavicIconsClass = { fg = c.orange, bg = "NONE" }
			-- 	c.NavicIconsMethod = { fg = c.blue, bg = "NONE" }
			-- 	c.NavicIconsProperty = { fg = c.cyan, bg = "NONE" }
			-- 	c.NavicIconsField = { fg = c.cyan, bg = "NONE" }
			-- 	c.NavicIconsConstructor = { fg = c.orange, bg = "NONE" }
			-- 	c.NavicIconsEnum = { fg = c.orange, bg = "NONE" }
			-- 	c.NavicIconsInterface = { fg = c.orange, bg = "NONE" }
			-- 	c.NavicIconsFunction = { fg = c.blue, bg = "NONE" }
			-- 	c.NavicIconsVariable = { fg = c.magenta, bg = "NONE" }
			-- 	c.NavicIconsConstant = { fg = c.magenta, bg = "NONE" }
			-- 	c.NavicIconsString = { fg = c.green, bg = "NONE" }
			-- 	c.NavicIconsNumber = { fg = c.orange, bg = "NONE" }
			-- 	c.NavicIconsBoolean = { fg = c.orange, bg = "NONE" }
			-- 	c.NavicIconsArray = { fg = c.orange, bg = "NONE" }
			-- 	c.NavicIconsObject = { fg = c.orange, bg = "NONE" }
			-- 	c.NavicIconsKey = { fg = c.violet500, bg = "NONE" }
			-- 	c.NavicIconsKeyword = { fg = c.violet500, bg = "NONE" }
			-- 	c.NavicIconsNull = { fg = c.orange, bg = "NONE" }
			-- 	c.NavicIconsEnumMember = { fg = c.cyan, bg = "NONE" }
			-- 	c.NavicIconsStruct = { fg = c.orange, bg = "NONE" }
			-- 	c.NavicIconsEvent = { fg = c.orange, bg = "NONE" }
			-- 	c.NavicIconsOperator = { fg = c.fg, bg = "NONE" }
			-- 	c.NavicIconsTypeParameter = { fg = c.cyan, bg = "NONE" }
			-- 	c.NavicText = { fg = c.fg, bg = "NONE" }
			-- 	c.NavicSeparator = { fg = c.fg, bg = "NONE" }
			-- end,
		},
		lazy = false,
		config = function(_, opts)
			require("solarized-osaka").setup(opts)

			vim.cmd.colorscheme("solarized-osaka")
		end,
		enabled = Is_Enabled("solarized-osaka.nvim"),
	},
	-- }}}
}
