return {
  "mason-org/mason-lspconfig.nvim",
  lazy = false,
  opts = {
    ensure_installed = { "lua_ls", "vtsls", "vue_ls", "cssls", "eslint", "html", "jsonls" },
    automatic_enable = {
      exclude = { "vtsls", "vue_ls" }
    }
  },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },

    {
      "neovim/nvim-lspconfig",
      config = function()
        local vue_language_server_path = vim.fn.stdpath('data') ..
            "/mason/packages/vue-language-server/node_modules/@vue/language-server"

        local tsserver_filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }

        local vue_plugin = {
          name = '@vue/typescript-plugin',
          location = vue_language_server_path,
          languages = { 'vue' },
          configNamespace = 'typescript',
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
          -- on_attach = function(client)
          --   if vim.bo.filetype == 'vue' then
          --     existing_capabilities.semanticTokensProvider.full = false
          --   else
          --     existing_capabilities.semanticTokensProvider.full = true
          --   end
          -- end,
          filetypes = tsserver_filetypes,
        }

        vim.lsp.config('vtsls', vtsls_config)

        vim.lsp.enable({ "vue_ls", "vtsls" })
      end
    }
  },
  setup = function(_, opts)
    require("mason-lspconfig").setup(opts)
  end,
}
