return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = "ConformInfo",
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
      lua = { "stylua" },
      javascript = { "prettierd" },
      typescript = { "prettierd" },
      vue = { "prettierd" },
    },
    format = {
      timeout_ms = 3000,
      async = true,
      quiet = false,
      lsp_fallback = true,
    },
    format_on_save = {
      lsp_fallback = true,
    },
  },
}
