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
    cmd = "Oil",
    opts = {
      keymaps = {
        ["q"] = { "actions.close", mode = "n" },
        ["<esc>"] = { "actions.close", mode = "n" },
        ["<C-h>"] = "actions.parent",
        ["<C-o>"] = "actions.parent",
      },
      show_hidden = true,
      view_options = {
        show_hidden = true,
      },
      skip_confirm_for_simpe_edits = true,
    },
    keys = { {
      "sf",
      function()
        require("oil").open_float()
      end,
    } },
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
  }, -- }}}
}
