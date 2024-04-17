Customize = require("config.customize")
Icons = require("config.constants").icons
Is_Enabled = require("config.functions").is_enabled

return {
	-- {{{ borrowed.nvim
	{
		"myypo/borrowed.nvim",
		lazy = false,
		priority = 1000,

		version = "^0", -- Optional: avoid upgrading to breaking versions

		config = function()
			-- require("borrowed").setup({ ... }) -- Optional: only has to be called to change settings

			-- If you are changing the config, colorscheme command has to be called after setup()
			vim.cmd("colorscheme mayu") -- OR vim.cmd("colorscheme shin")
		end,
	},
	-- }}}
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
			-- autopairs = { enable = true },
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
				enable = Is_Enabled("nvim-ts-rainbow2"),
				extended_mode = false,
				max_file_lines = nil,
				query = "rainbow-parens",
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
			{ "HiPhish/nvim-ts-rainbow2", enabled = Is_Enabled("nvim-ts-rainbow2") },
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
		"HiPhish/nvim-ts-rainbow2",
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
			style = "moon",
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		},
		config = function(_, opts)
			require("tokyonight").setup(opts)

			vim.cmd.colorscheme("tokyonight")
		end,
	},
	-- ----------------------------------------------------------------------- }}}
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
	-- {{{ sainhe/sonokai
	{
		"sainnhe/sonokai",
		lazy = false,
		enabled = false,
		init = function()
			vim.g.sonokai_style = "andromeda"
			vim.g.sonokai_transparent_background = 1
		end,
		config = function()
			vim.cmd.colorscheme("sonokai")
		end,
	},
	-- }}}
}
