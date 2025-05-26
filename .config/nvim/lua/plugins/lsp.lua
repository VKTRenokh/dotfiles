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
    opts_extend = { "ensure_installed" },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")

      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },
  -- ----------------------------------------------------------------------- }}}
  {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    enabled = true,
    keys = {
      -- stylua: ignore start
      { "<localleader>d", vim.lsp.implementation,  desc = "Goto implementation" },
      { "gI",             vim.lsp.buf.code_action, desc = "Code action" },
      { "<leader>r",      vim.lsp.buf.rename,      desc = "Rename variable" },
      -- stylua: ignore end
    },
    dependencies = {
      "mason.nvim",
      {
        "williamboman/mason-lspconfig.nvim",
        branch = "release-please--branches--main--components--mason-lspconfig.nvim",
      },
      "saghen/blink.cmp",
    },
    opts = function()
      return {
        diagnostics = {
          virtual_lines = {
            current_line = true,
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
          vue_ls = {},
          ts_ls = {
            mason = false,
            enabled = false,
            enable = false,
            init_options = {
              plugins = {
                {
                  name = "@vue/typescript-plugin",
                  location = vim.fn.expand("$MASON/packages")
                    .. "/vue-language-server/node_modules/@vue/language-server",
                  languages = { "vue" },
                },
              },
            },
            filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
          },
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
      }
    end,
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
        all_mslp_servers = vim.tbl_keys(mlsp.get_mappings().lspconfig_to_package)
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
          automatic_enable = true,
        })
      end
    end,
  },
  -- ----------------------------------------------------------------------- }}}
}
