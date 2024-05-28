Constants = require("config.constants")

return {
  -- {{{ mason.nvim
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
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
			{ "<leader>Ll", function() vim.lsp.codelens.run() end, },
			{ "<leader>Lq", function() vim.lsp.diagnostic.set_loclist() end, },
			{ "gI", function() vim.lsp.buf.code_action() end, },
			{ "<leader>r", function() vim.lsp.buf.rename() end, desc = "Rename variable" },
      -- stylua: ignore end
    },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        "hrsh7th/cmp-nvim-lsp",
      },
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
        lua_ls = {
          settings = {
            Lua = Constants.lua_ls.Lua,
          },
        },
      },
      setup = {},
    },
    config = function(_, opts)
      require("config.lsp-config")(opts)
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
        mode = { "x", "n", "v" },
        desc = "Format file or selection",
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
        lsp_fallback = true,
      },
    },
  },
  -- }}}
  -- {{{ neodev.nvim
  { "folke/neodev.nvim", enabled = false },
  -- ----------------------------------------------------------------------- }}}
  -- {{{ neoconf.nvim
  { "folke/neoconf.nvim", enabled = false, cmd = "Neoconf", config = true },
  -- ----------------------------------------------------------------------- }}}
}
