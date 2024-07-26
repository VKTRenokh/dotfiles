Constants = require("config.constants")
local map = require("config.functions").keymap

return {
  -- {{{ mason.nvim
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
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
      max_concurrent_installers = 10,
      ensure_installed = Constants.ensure_installed.mason,
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
  -- ----------------------------------------------------------------------- }}}
  -- {{{ nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    keys = {
      -- stylua: ignore start
      { "<localleader>d", vim.lsp.implementation, desc = "Goto implementation" },
			{ "gI", vim.lsp.buf.code_action, desc = "Code action" },
			{ "<leader>r", vim.lsp.buf.rename, desc = "Rename variable" },
      -- stylua: ignore end
    },
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = { spacing = 4, source = "if_many", prefix = "●" },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = Icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = Icons.diagnostics.Warning,
            [vim.diagnostic.severity.HINT] = Icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = Icons.diagnostics.Information,
          },
        },
      },
      capabilities = {},
      servers = {
        jsonls = require("plugins.lsp.jsonls"),
        vtsls = { -- {{{
          enabled = false, -- NOTE: disable typescript-language-server if this server is enabled
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.jsx",
          },
          settings = {
            complete_function_calls = true,
            vtsls = {
              enableMoveToFileCodeAction = true,
              autoUseWorkspaceTskd = true,
              experimental = {
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
            },
            typescript = {
              suggest = { completeFunctionCalls = true },
              updateImportsOnFileMove = { enabled = "always" },
            },
            inlayHints = {
              enumMemberValues = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              parameterNames = { enabled = "literals" },
              parameterTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              variableTypes = { enabled = false },
            },
          },
        }, -- }}}}}}
        volar = { -- {{{
          filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
          init_options = {
            vue = {
              hybridMode = false,
            },
          },
        }, -- }}}
        tsserver = { -- {{{
          enabled = true, -- NOTE: disable tsserver if vtsls is enabled
        }, -- }}}
        lua_ls = {
          settings = {
            Lua = Constants.lua_ls.Lua,
          },
        },
      },
      setup = {},
      document_highlight = {
        enabled = true,
      },
    },
    config = function(_, opts)
      vim.diagnostic.config(opts.diagnostics)

      map("n", "gd", vim.lsp.buf.definition, { desc = "goto defenition" })

      local servers = opts.servers

      local hasCmp, cmpNvimLsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        hasCmp and cmpNvimLsp.default_capabilities() or {},
        opts.capabilities or {}
      )

      local function setup(server)
        local serverOpts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})

        if opts.setup[server] then
          if opts.setup[server](server, serverOpts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, serverOpts) then
            return
          end
        end

        require("lspconfig")[server].setup(serverOpts)
      end

      local hasMason, mlsp = pcall(require, "mason-lspconfig")
      local allMslpServers = {}

      if hasMason then
        allMslpServers =
          vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      end

      local ensureInstalled = {} ---@type string[]
      for server, serverOpts in pairs(servers) do
        if serverOpts then
          serverOpts = serverOpts == true and {} or serverOpts

          if serverOpts.mason == false or not vim.tbl_contains(allMslpServers, server) then
            setup(server)
          elseif serverOpts.enabled ~= false then
            ensureInstalled[#ensureInstalled + 1] = server
          end
        end
      end

      if hasMason then
        mlsp.setup({ ensure_installed = ensureInstalled, handlers = { setup } })
      end
    end,
  },
  -- ----------------------------------------------------------------------- }}}
}
