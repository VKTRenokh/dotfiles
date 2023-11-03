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
		keys = {
			{
				"<leader>LF",
				"<cmd>LspToggleAutoFormat<cr>",
			},
			{
				"<leader>Li",
				"<cmd>LspInfo<cr>",
			},
			{
				"<leader>Ll",
				function()
					vim.lsp.codelens.run()
				end,
			},
			{
				"<leader>Lq",
				function()
					vim.lsp.diagnostic.set_loclist()
				end,
			},
			{
				"<leader>La",
				function()
					vim.lsp.buf.code_action()
				end,
			},
			{
				"<leader>Lf",
				function()
					vim.lsp.buf.format({ async = true })
				end,
			},
			{
				"<leader>r",
				function()
					vim.lsp.buf.rename()
				end,
			},
		},
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
			"SmiteshP/nvim-navic",
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
				-- jsonls = require("plugins.lsp.jsonls"),
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

			local have_mason, mlsp = pcall(require, "mason-lspconfig")
			local available = have_mason and mlsp.get_available_servers() or {}

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

			if have_mason then
				mlsp.setup({ ensure_installed = ensure_installed })
				mlsp.setup_handlers({ setup })
			end
		end,
	},
	-- ----------------------------------------------------------------------- }}}
	-- {{{ conform.nvim
	{
		"stevearc/conform.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				javascript = { { "prettierd", "eslint_d" } },
				typescript = { { "prettierd", "eslint_d" } },
			},
			diagnostics = {
				javascript = { { "eslint_d" } },
				typescript = { { "eslint_d" } },
			},
			format_on_save = {
				-- These options will be passed to conform.format()
				-- timeout_ms = 500,
				lsp_fallback = true,
			},
		},
	},
	-- }}}
	-- {{{ nvim-lint
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
			}

			local lint_augroup = vim.api.nvim_create_augroup("lint", {
				clear = true,
			})

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				pattern = { "*.ts", "*.js" },
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
	-- }}}
	-- {{{ symbols-outline.nvim
	{
		"simrat39/symbols-outline.nvim",
		enabled = Is_Enabled("symbols-outline"),
		keys = {
			{ "<leader>o", "<cmd>SymbolsOutline<cr>" },
		},
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
			keymaps = {
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
}
