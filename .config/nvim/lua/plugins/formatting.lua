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
    {
      "<leader>fd",
      desc = "Toggle autoformatting for buffer",
      function()
        vim.b[0].disable_autoformat = not (vim.g.disable_autoformat == nil and true or false)

        require("config.functions").notify("Disabled autoformatting in current buffer")
      end,
    },
    {
      "<leader>fD",
      desc = "Toggle autoformatting",
      function()
        vim.g.disable_autoformat = not (vim.g.disable_autoformat == nil and true or false)

        require("config.functions").notify(
          vim.g.disable_autoformat and "Enabled autoformatting" or "Disabled autoformatting"
        )
      end,
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
    },
    format = {
      timeout_ms = 3000,
      async = true,
      quiet = false,
      lsp_fallback = true,
    },
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end

      return {
        lsp_fallback = true,
        timeout_ms = 3000,
      }
    end,
  },
}
