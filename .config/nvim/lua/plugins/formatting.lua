return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = "ConformInfo",
  enabled = true,
  keys = {
    {
      "<leader>fr",
      function()
        require("conform").format()
      end,
      mode = { "x", "n", "v" },
    },
  },
  opts = {
    formatters_by_ft = {
      ["lua"] = { "stylua" },
      ["javascript"] = { "prettierd" },
      ["typescript"] = { "prettierd" },
      ["javascriptreact"] = { "prettierd" },
      ["typescriptreact"] = { "prettierd" },
      ["vue"] = { "prettierd" },
      ["markdown"] = { "prettierd" },
      ["markdown.mdx"] = { "prettierd" },
      ["css"] = { "prettierd" },
      ["scss"] = { "prettierd" },
      ["html"] = { "prettierd" },
    },
    format = {
      timeout_ms = 3000,
      async = true,
      quiet = false,
      lsp_fallback = true,
    },
    format_on_save = function(bufnr)
      local is_formatting_enabled = true

      local opts = {
        lsp_fallback = true,
        timeout_ms = 3000,
        enabled = false,
      }

      return is_formatting_enabled and opts or nil
    end,
  },
}
