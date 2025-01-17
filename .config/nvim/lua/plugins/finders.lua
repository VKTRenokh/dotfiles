Constants = require("config.constants")

return {
  -- {{{ fzf-lua
  {
    "ibhagwan/fzf-lua",
    cmd = "FzFLua",
    keys = {
        -- stylua: ignore start
      { ";f", function() require("fzf-lua").files() end },
      { ";r", function () require('fzf-lua').live_grep() end },
      { ";e", function () require('fzf-lua.providers.diagnostic').diagnostics() end },
      { ";s", function () require('fzf-lua.providers.lsp').document_symbols() end },
      { "gr", function () require('fzf-lua.providers.lsp').references() end },
      { "gd", function () require('fzf-lua.providers.lsp').references() end },
      -- stylua: ignore end
    },
    dependencies = { "echasnovski/mini.icons" },
    opts = {
      winopts = {
        fullscreen = false,
      },
      preview = {
        title_pos = "left",
      },
    },
  }, -- }}}
  -- {{{ oil.nvim
  {
    "stevearc/oil.nvim",
    opts = {
      keymaps = {
        ["q"] = { "actions.close", mode = "n" },
      },
    },
    keys = { { "sf", "<cmd>:Oil<cr>" } },
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
  }, -- }}}
}
