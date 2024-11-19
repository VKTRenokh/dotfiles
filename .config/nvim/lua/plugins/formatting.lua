return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = "ConformInfo",
  enabled = false,
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
      -- local bufname = vim.api.nvim_buf_get_name(bufnr)

      return {
        lsp_fallback = true,
        timeout_ms = 3000,
      }
    end,
  },
}
