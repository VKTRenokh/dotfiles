return {
  {
    "Olical/nfnl",
    ft = { "fennel" },
  },
  {
    "echasnovski/mini.keymap",
    event = "LazyFile",
    opts = {},
    config = function(_, opts)
      local keymap = require("mini.keymap")

      keymap.setup(opts)

      local mode = { "i", "c", "x", "s" }

      keymap.map_combo(mode, "jk", "<BS><BS><Esc>")
    end,
  },
}
