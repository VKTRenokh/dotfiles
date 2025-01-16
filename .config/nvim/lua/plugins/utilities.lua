return {
  -- {{{ plenary
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },
  -- ----------------------------------------------------------------------- }}}
  -- {{{ Olical nfnl
  {
    "Olical/nfnl",
    ft = { "fennel" },
  },
  -- }}}
  {
    "nvzone/typr",
    cmd = "TyprStats",
    dependencies = "nvzone/volt",
    opts = {},
  },
}
