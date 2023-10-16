local Constants = {}

-- {{{ Begin Constants table.  These are items used through out Neovim.

Constants = {

	-- ----------------------------------------------------------------------- }}}
	-- {{{ lua_ls settings

	lua_ls = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			completion = {
				callSnippet = "Replace",
			},
			workspace = {
				library = {
					-- [vim.fn.expand("$VIMRUNTIME/lua")] = true,
					-- [vim.fn.stdpath("config") .. "/lua"] = true,
					-- library = vim.api.nvim_get_runtime_file("", true),
					checkThirdParty = false,
				},
			},
		},
	},

	-- ----------------------------------------------------------------------- }}}
	-- {{{ Languages lsp_config, mason, and treesitter ensures are installed

	ensure_installed = {
		lsp_config = {
			"bashls",
			"clangd",
			"cssls",
			"diagnosticls",
			"emmet_ls",
			"eslint",
			"html",
			"jsonls",
			"lua_ls",
			"pyright",
			"rust_analyzer",
			"tsserver",
			"yaml",
			"docker",
			"angularls",
			"fennel",
			"volar",
		},
		mason = {
			"bash-language-server",
			"clangd",
			"css-lsp",
			"emmet-ls",
			"eslint-lsp",
			"flake8",
			"html-lsp",
			"json-lsp",
			"lua-language-server",
			"pyright",
			"rust-analyzer",
			"typescript-language-server",
			"yaml-language-server",
			"angular-language-server",
			"stylua",
			"prettierd",
			"fennel-language-server",
		},
		treesitter = {
			"bash",
			"c",
			"cpp",
			"css",
			"dockerfile",
			"html",
			"javascript",
			"json",
			"lua",
			"markdown",
			"vue",
			"markdown_inline",
			"python",
			"query",
			"regex",
			"rust",
			"tsx",
			"javascript",
			"typescript",
			"vim",
			"yaml",
			"fennel",
		},
	},

	-- ----------------------------------------------------------------------- }}}
	-- {{{ Language lsp_config, mason, and treesitter ensures are disabled.

	disabled = {
		lsp_config = {},
		mason = {},
		treesitter = {
			"html",
			"latex",
			"markdown",
		},
	},

	-- ----------------------------------------------------------------------- }}}
	-- {{{ File type events

	file_types = {
		"BufEnter *.c",
		"BufEnter *.cpp",
		"BufEnter *.cs",
		"BufEnter *.go",
		"BufEnter *.java",
		"BufEnter *.lua",
		"BufEnter *.py",
		"BufEnter *.rb",
		"BufEnter *.rs",
		"BufEnter *.ts",
		"BufEnter *.js",
	},

	-- ------------------------------------------------------------------------- }}}
	-- {{{ Icons
	icons = {
		dap = {
			expanded = "",
			collapsed = "",
			circular = "",
		},
		diagnostics = {
			Error = " ",
			Warning = " ",
			Information = " ",
			Question = " ",
			Hint = " ",
		},
		kind = {
			Text = " ",
			Method = " ",
			Function = " ",
			Constructor = " ",
			Field = " ",
			Variable = " ",
			Class = " ",
			Interface = "ﰮ",
			Module = " ",
			Property = " ",
			Unit = " ",
			Value = " ",
			Enum = " ",
			Keyword = " ",
			Snippet = "﬌ ",
			Color = " ",
			File = " ",
			Reference = " ",
			Folder = " ",
			EnumMember = " ",
			Constant = "󰏿 ",
			Struct = " ",
			Event = " ",
			Operator = "ﬦ",
			TypeParameter = " ",
			Misc = " ",
		},
		type = {
			Array = " ",
			Number = " ",
			String = " ",
			Boolean = " ",
			Object = " ",
		},
		documents = {
			File = " ",
			Files = " ",
			Folder = " ",
			OpenFolder = " ",
		},
		git = {
			Add = " ",
			Mod = " ",
			Remove = " ",
			Ignore = " ",
			Rename = " ",
			Diff = " ",
			Repo = " ",
			Octoface = " ",
			Branch = "",
		},
		misc = {
			Robot = " ",
			Squirrel = " ",
			Tag = " ",
			Watch = " ",
			Smiley = " ",
			Package = " ",
			CircuitBoard = " ",
		},
		ui = {
			ArrowClosed = { icon = "", color = "#ffcb91", name = "kt" },
			ArrowOpen = "",
			Lock = " ",
			Circle = " ",
			BigCircle = " ",
			BigUnfilledCircle = " ",
			BigCircleSeparatorLeft = "",
			BigCircleSeparatorRight = "",
			Close = " ",
			NewFile = " ",
			Search = " ",
			Lightbulb = " ",
			Project = " ",
			Dashboard = " ",
			History = " ",
			Comment = " ",
			Bug = " ",
			Code = " ",
			Telescope = "  ",
			Gear = " ",
			Package = " ",
			List = " ",
			SignIn = " ",
			SignOut = " ",
			SlashLeft = "",
			SlashRight = "",
			NoteBook = " ",
			Check = " ",
			Fire = " ",
			Note = " ",
			BookMark = " ",
			Pencil = " ",
			ChevronRight = " ",
			Table = " ",
			Calendar = " ",
			CloudDownload = " ",
		},
		web_devicons = {
			Dockerfile = { icon = "", color = "#b8b5ff", name = "Dockerfile" },
			css = { icon = "", color = "#61afef", name = "css" },
			deb = { icon = "", color = "#a3b8ef", name = "deb" },
			html = { icon = "", color = "#DE8C92", name = "html" },
			jpeg = { icon = " ", color = "#BD77DC", name = "jpeg" },
			jpg = { icon = " ", color = "#BD77DC", name = "jpg" },
			js = { icon = "", color = "#EBCB8B", name = "js" },
			kt = { icon = "󱈙", color = "#ffcb91", name = "kt" },
			lock = { icon = "", color = "#DE6B74", name = "lock" },
			md = { icon = "", color = "#b8b5ff", name = "mp3" },
			mp3 = { icon = "", color = "#C8CCD4", name = "mp3" },
			mp4 = { icon = "", color = "#C8CCD4", name = "mp4" },
			out = { icon = "", color = "#C8CCD4", name = "out" },
			png = { icon = " ", color = "#BD77DC", name = "png" },
			py = { icon = "", color = "#a7c5eb", name = "py" },
			rb = { icon = "", color = "#ff75a0", name = "rb" },
			rpm = { icon = "", color = "#fca2aa", name = "rpm" },
			toml = { icon = "", color = "#61afef", name = "toml" },
			ts = { icon = "ﯤ", color = "#519ABA", name = "ts" },
			vue = { icon = "﵂", color = "#7eca9c", name = "vue" },
			xz = { icon = "", color = "#EBCB8B", name = "xz" },
			yaml = { icon = "", color = "#EBCB8B", name = "xz" },
			zip = { icon = "", color = "#EBCB8B", name = "zip" },
		},
	},

	-- ------------------------------------------------------------------------- }}}
	-- {{{ Rainbow colors

	colors = {
		rainbow = {
			"Gold",
			"Orchid",
			"DodgerBlue",
			"Cornsilk",
			"Salmon",
			"LawnGreen",
		},
	},

	-- ----------------------------------------------------------------------- }}}
	-- {{{ Display boarders

	display_border = {
		border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
	},

	-- ----------------------------------------------------------------------- }}}
	-- {{{ Completion source mapping

	completion = {
		source_mapping = {
			nvim_lsp = "[LSP]",
			luasnip = "[Snippet]",
			buffer = "[Buffer]",
			path = "[Path]",
			nvim_lua = "[Lua]",
			-- spell = "[Spell]",
		},

		sources = {
			{ name = "nvim_lsp", keyword_length = 2, max_item_count = 30 },
			{ name = "luasnip", keyword_length = 1, max_item_count = 30 },
			{ name = "buffer", keyword_length = 2, max_item_count = 30 },
			{ name = "path", keyword_length = 3, max_item_count = 30 },
			{ name = "nvim_lua", keyword_length = 1, max_item_count = 30 },
			{ name = "calc", keyword_length = 2, max_item_count = 30 },
			--  { name = "spell", keyword_length = 2, max_item_count = 30 },
		},
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ End Constants table.
}
-- ----------------------------------------------------------------------- }}}
return Constants
