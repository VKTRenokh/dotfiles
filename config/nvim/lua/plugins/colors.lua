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
				vim.cmd([[colorscheme tokyonight]])
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
		},

		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,

		dependencies = {
			"windwp/nvim-ts-autotag",
			"mrjones2014/nvim-ts-rainbow",
			"JoosepAlviste/nvim-ts-context-commentstring",
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
			style = "night",
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		},
		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.cmd([[ colorscheme tokyonight-night ]])
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
}
