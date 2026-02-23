Constants = require("config.constants")

return {
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
    keys = {
      {
        "sf",
        function()
          require("oil").open_float()

          vim.b.completion = false
        end,
      },
      {
        "sF",
        function()
          require("oil").open()

          vim.b.completion = false
        end,
      }
    },
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  }, -- }}}
}
