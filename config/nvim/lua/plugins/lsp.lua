Constants = require("config.constants")
Is_Enabled = require("config.functions").is_enabled

return {
	-- {{{ mason.nvim
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		enabled = Is_Enabled("mason.nvim"),
		opts = {
			ui = {
				border = "rounded",
				icons = {
					package_installed = "◍",
					package_pending = "◍",
					package_uninstalled = "◍",
				},
			},
			log_level = vim.log.levels.INFO,
			max_concurrent_installers = 4,
			ensure_installed = Constants.ensure_installed.mason,
		},
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			for _, tool in ipairs(opts.ensure_installed) do
				local p = mr.get_package(tool)
				if not p:is_installed() then
					p:install()
				end
			end
		end,
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ nvim-lspconfig
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		enabled = Is_Enabled("lsp-config"),
		dependencies = {
			{ "folke/neoconf.nvim", cmd = "Neoconf", config = true },
			{ "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			{
				"hrsh7th/cmp-nvim-lsp",
				cond = function()
					return Is_Enabled("nvim-cmp")
				end,
			},
		},
		opts = {
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = { spacing = 4, prefix = "●" },
				severity_sort = true,
			},
			autoformat = true,
			format = {
				formatting_options = nil,
				timeout_ms = nil,
			},
			servers = {
				jsonls = require("plugins.lsp.jsonls"),
				lua_ls = {
					settings = {
						Lua = Constants.lua_ls.Lua,
					},
				},
			},
			setup = {
				-- example to setup with typescript.nvim
				-- tsserver = function(_, opts)
				--   require("typescript").setup({ server = opts })
				--   return true
				-- end,
				-- Specify * to use this function as a fallback for any server
				-- ["*"] = function(server, opts) end,
			},
		},
		config = function(_, opts)
			-- require("plugins.lsp.format").autoformat = opts.autoformat
			require("config.functions").on_attach(function(client, buffer)
				-- require("plugins.lsp.format").on_attach(client, buffer)
				require("plugins.lsp.keymaps").on_attach(client, buffer)
			end)

			for name, icon in pairs(Constants.icons.diagnostics) do
				name = "DiagnosticSign" .. name
				vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
			end
			vim.diagnostic.config(opts.diagnostics)

			local servers = opts.servers
			local capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

			local function setup(server)
				local server_opts = vim.tbl_deep_extend("force", {
					capabilities = vim.deepcopy(capabilities),
				}, servers[server] or {})

				if opts.setup[server] then
					if opts.setup[server](server, server_opts) then
						return
					end
				elseif opts.setup["*"] then
					if opts.setup["*"](server, server_opts) then
						return
					end
				end
				require("lspconfig")[server].setup(server_opts)
			end

			-- temp fix for lspconfig rename
			-- https://github.com/neovim/nvim-lspconfig/pull/2439
			local mappings = require("mason-lspconfig.mappings.server")
			if not mappings.lspconfig_to_package.lua_ls then
				mappings.lspconfig_to_package.lua_ls = "lua-language-server"
				mappings.package_to_lspconfig["lua-language-server"] = "lua_ls"
			end

			local mlsp = require("mason-lspconfig")
			local available = mlsp.get_available_servers()

			local ensure_installed = {} ---@type string[]
			for server, server_opts in pairs(servers) do
				if server_opts then
					server_opts = server_opts == true and {} or server_opts
					-- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
					if server_opts.mason == false or not vim.tbl_contains(available, server) then
						setup(server)
					else
						ensure_installed[#ensure_installed + 1] = server
					end
				end
			end

			require("mason-lspconfig").setup({ ensure_installed = ensure_installed })
			require("mason-lspconfig").setup_handlers({ setup })
		end,
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ null-ls.nvim
	{
		"jose-elias-alvarez/null-ls.nvim",
		enabled = Is_Enabled("null-ls.nvim"),
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "mason.nvim" },
		opts = function()
			local nls = require("null-ls")
			local diagnostics = nls.builtins.diagnostics
			local codeActions = nls.builtins.code_actions
			return {
				root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
				sources = {
					diagnostics.eslint_d.with({
						diagnostics_format = "[eslint] #{m}\n(#{c})",
					}),
					diagnostics.eslint,
					codeActions.eslint_d,
				},
			}
		end,
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ symbols-outline.nvim
	{
		"simrat39/symbols-outline.nvim",
		enabled = Is_Enabled("symbols-outline"),
		cmd = "SymbolsOutline",
		lazy = true,
		opts = {
			highlight_hovered_item = true,
			show_guides = true,
			auto_preview = false,
			position = "right",
			relative_width = true,
			width = 45,
			auto_close = false,
			show_numbers = false,
			show_relative_numbers = false,
			show_symbol_details = true,
			preview_bg_highlight = "Pmenu",
			autofold_depth = nil,
			auto_unfold_hover = true,
			fold_markers = { "", "" },
			wrap = false,
			keymaps = { -- These keymaps can be a string or a table for multiple keys
				close = { "<Esc>", "q" },
				goto_location = "<Cr>",
				focus_location = "o",
				hover_symbol = "<C-space>",
				toggle_preview = "K",
				rename_symbol = "r",
				code_actions = "a",
				fold = "h",
				unfold = "l",
				fold_all = "W",
				unfold_all = "E",
				fold_reset = "R",
			},
			lsp_blacklist = {},
			symbol_blacklist = {},
			symbols = {
				File = { icon = Constants.icons.kind.File, hl = "@text.uri" },
				Module = { icon = Constants.icons.kind.Module, hl = "@namespace" },
				Namespace = { icon = Constants.icons.type.Array, hl = "@namespace" },
				Package = { icon = Constants.icons.misc.Package, hl = "@namespace" },
				Class = { icon = Constants.icons.kind.Class, hl = "@type" },
				Method = { icon = Constants.icons.kind.Method, hl = "@method" },
				Property = { icon = Constants.icons.kind.Property, hl = "@method" },
				Field = { icon = Constants.icons.kind.Field, hl = "@field" },
				Constructor = { icon = Constants.icons.kind.Constructor, hl = "@constructor" },
				Enum = { icon = Constants.icons.kind.Enum, hl = "@type" },
				Interface = { icon = Constants.icons.kind.Interface, hl = "@type" },
				Function = { icon = Constants.icons.kind.Function, hl = "@function" },
				Variable = { icon = Constants.icons.kind.Variable, hl = "@constant" },
				Constant = { icon = Constants.icons.kind.Constant, hl = "@constant" },
				String = { icon = Constants.icons.kind.Struct, hl = "@string" },
				Number = { icon = Constants.icons.kind.Number, hl = "@number" },
				Boolean = { icon = Constants.icons.kind.Boolean, hl = "@boolean" },
				Array = { icon = Constants.icons.type.Array, hl = "@constant" },
				Object = { icon = Constants.icons.type.Object, hl = "@type" },
				Key = { icon = "🔐", hl = "@type" },
				Null = { icon = "NULL", hl = "@type" },
				EnumMember = { icon = Constants.icons.kind.EnumMember, hl = "@field" },
				Struct = { icon = Constants.icons.kind.Struct, hl = "@type" },
				Event = { icon = Constants.icons.kind.Event, hl = "@type" },
				Operator = { icon = Constants.icons.kind.Operator, hl = "@operator" },
				TypeParameter = { icon = Constants.icons.kind.TypeParameter, hl = "@parameter" },
				Component = { icon = Constants.icons.type.Array, hl = "@function" },
				Fragment = { icon = Constants.icons.type.Array, hl = "@constant" },
			},
		},
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ neodev.nvim
	{ "folke/neodev.nvim", enabled = Is_Enabled("neodev.nvim") },
	-- ----------------------------------------------------------------------- }}}
	-- {{{ neoconf.nvim
	{ "folke/neoconf.nvim", enabled = Is_Enabled("neoconf.nvim"), cmd = "Neoconf", config = true },
	-- ----------------------------------------------------------------------- }}}
	-- {{{ lspsaga
	{
		"glepnir/lspsaga.nvim",
		event = "BufRead",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			local saga = require("lspsaga")
			saga.setup({
				ui = {
					border = "rounded",
					expand = "",
					collapse = "",
					preview = " ",
					code_action = "💡",
					diagnostic = "🐞",
					incoming = " ",
					outgoing = " ",
					colors = {
						normal_bg = "#002b36",
					},
				},
				finder = {
					edit = { "o", "<CR>" },
					vsplit = "s",
					split = "i",
					tabe = "t",
					quit = { "q", "<ESC>" },
					open = "o",
				},
				lightbulb = {
					enable = true,
					enable_in_insert = true,
					sign = true,
					sign_priority = 40,
					virtual_text = true,
				},
				symbol_in_winbar = {
					enable = true,
					separator = "  ",
					hide_keyword = true,
					show_file = true,
					folder_level = 2,
					respect_root = true,
					color_mode = true,
				},
				show_outline = {
					win_position = "right",
					win_width = 30,
					auto_enter = true,
					auto_preview = true,
					virt_text = "┃",
					auto_refresh = true,
					color = {
						normal_bg = "NONE",
					},
				},
			})

			--[[   finder_icons = { ]]
			--[[     def = '  ', ]]
			--[[     ref = '諭 ', ]]
			--[[     link = '  ', ]]
			--[[   }, ]]

			local opts = { noremap = true, silent = true }
			vim.keymap.set("n", "<C-j>", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
			vim.keymap.set("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)
			vim.keymap.set("n", "gh", "<Cmd>Lspsaga lsp_finder<CR>", opts)
			vim.keymap.set("n", "gd", "<Cmd>Lspsaga goto_definition<CR>", opts)
			vim.keymap.set("n", "<C-k>", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
			vim.keymap.set("n", "gp", "<Cmd>Lspsaga peek_definition<CR>", opts)
			vim.keymap.set("n", "<leader>r", "<Cmd>Lspsaga rename<CR>", opts)
			vim.keymap.set("n", "<leader>o", "<Cmd>Lspsaga outline<CR>", opts)
			vim.keymap.set("n", "<leader>ca", "<Cmd>Lspsaga code_action<CR>", opts)
		end,
	},
	-- }}}
}
