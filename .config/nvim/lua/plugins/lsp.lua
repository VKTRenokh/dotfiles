return {
  "mason-org/mason-lspconfig.nvim",
  event = "VeryLazy",
  opts = {
    ensure_installed = { "lua_ls", "vtsls", "vue_ls", "cssls", "html", "jsonls", "zls" },
    automatic_enable = {
      exclude = { "vtsls", "vue_ls" },
    },

    config = function()
      for k, v in ipairs(require('mason-lspconfig').get_available_servers()) do
        print(k, v)
      end
    end
  },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },

    {
      "neovim/nvim-lspconfig",
      config = function()
        local vue_language_server_path = vim.fn.stdpath("data")
            .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

        local tsserver_filetypes =
        { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }

        local vue_plugin = {
          name = "@vue/typescript-plugin",
          location = vue_language_server_path,
          languages = { "vue" },
          configNamespace = "typescript",
        }

        local vtsls_config = {
          settings = {
            vtsls = {
              tsserver = {
                globalPlugins = {
                  vue_plugin,
                },
              },
            },
          },
          filetypes = tsserver_filetypes,
        }

        vim.lsp.config("vtsls", vtsls_config)

        vim.lsp.enable({ "vue_ls", "vtsls" })

        vim.diagnostic.config({
          update_in_insert = false,
          -- virtual_lines = {
          --   current_line = true,
          -- },
          virtual_text = false,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = "",
              [vim.diagnostic.severity.WARN] = "",
              [vim.diagnostic.severity.HINT] = "",
              [vim.diagnostic.severity.INFO] = "",
            },
          },
        })
      end,
    },
  },
  setup = function(_, opts)
    require("mason-lspconfig").setup(opts)
  end,
}
