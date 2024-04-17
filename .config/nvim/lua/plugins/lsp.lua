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
				"gi",
				function()
					vim.lsp.buf.code_action()
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
		},
		opts = {
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = { spacing = 4, source = "if_many", prefix = "●" },
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
		event = { "BufWritePre" },
		keys = {
			{
				"<leader>fr",
				function()
					require("conform").format()
				end,
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { { "prettierd" } },
				typescript = { { "prettierd" } },
				vue = { { "prettierd" } },
			},
			format_on_save = {
				-- These options will be passed to conform.format()
				-- timeout_ms = 500,
				lsp_fallback = true,
			},
		},
		enabled = Is_Enabled("conform.nvim"),
	},
	-- }}}
	-- {{{ neodev.nvim
	{ "folke/neodev.nvim", enabled = Is_Enabled("neodev.nvim") },
	-- ----------------------------------------------------------------------- }}}
	-- {{{ neoconf.nvim
	{ "folke/neoconf.nvim", enabled = Is_Enabled("neoconf.nvim"), cmd = "Neoconf", config = true },
	-- ----------------------------------------------------------------------- }}}
}
