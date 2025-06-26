return {
  {
    "echasnovski/mini.keymap",
    event = "LazyFile",
    opts = {},
    enabled = false,
    config = function(_, opts)
      local keymap = require("mini.keymap")

      keymap.setup(opts)

      local mode = { "i", "c", "x", "s" }

      keymap.map_combo(mode, "jk", "<BS><BS><Esc>")
    end,
  },
  {
    "stevearc/quicker.nvim",
    event = "FileType qf",
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {},
  },
  -- {{{
  {
    "echasnovski/mini.diff",
    opts = {},
    keys = {
      {
        "<leader>dv",
        function()
          MiniDiff.toggle_overlay()
        end,
      },
    },
  },
  -- }}}
}
