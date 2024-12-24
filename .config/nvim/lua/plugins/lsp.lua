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
      "saghen/blink.cmp",
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
      capabilities = {
        workspace = {
          fileOperations = {
            didRename = true,
            willRename = true,
          },
        },
      },
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
        ts_ls = { -- {{{
          enabled = true, -- NOTE: disable tsserver if vtsls is enabled
        }, -- }}}
        lua_ls = {
          settings = {
            Lua = Constants.lua_ls.Lua,
          },
        },
        zls = {
          cmd = { "/home/vktrenokh/.local/bin/zls" },
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
      local has_blink, blink = pcall(require, "blink.cmp")

      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_blink and blink.get_lsp_capabilities() or {},
        opts.capabilities or {}
      )

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})
        if server_opts.enabled == false then
          return
        end

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

      -- get all the servers that are available through mason-lspconfig
      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      local all_mslp_servers = {}
      if have_mason then
        all_mslp_servers =
          vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      end

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          if server_opts.enabled ~= false then
            -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
            if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
              setup(server)
            else
              ensure_installed[#ensure_installed + 1] = server
            end
          end
        end
      end

      if have_mason then
        mlsp.setup({
          -- TODO: fix this (Constants.ensure_installed.mason)
          ensure_installed = vim.tbl_deep_extend("force", ensure_installed, {}),
          handlers = { setup },
        })
      end
    end,
  },
  -- ----------------------------------------------------------------------- }}}
}
