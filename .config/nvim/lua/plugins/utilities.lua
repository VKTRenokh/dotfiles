return {
  -- {{{ plenary
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },
  -- ----------------------------------------------------------------------- }}}
  -- {{{ toggleterm.nvim
  {
    "akinsho/toggleterm.nvim",
    keys = {
      {
        "<leader>TT",
        "<Cmd>ToggleTerm<cr>",
        desc = "Open floating terminal",
      },
    },
    cmd = "ToggleTerm",
    version = "*",
    opts = {
      size = 13,
      open_mapping = [[<c-\>]],
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = "1",
      start_in_insert = true,
      persist_size = true,
      direction = "float",
    },
  },
  -- ----------------------------------------------------------------------- }}}
  -- {{{ mini.bufremove
  {
    "echasnovski/mini.bufremove",
    opts = {
      silent = true,
    },
    keys = {
      {
        "<leader>bd",
        function()
          require("mini.bufremove").delete(0)
        end,
        desc = "Delete Buffer",
      },
    -- stylua: ignore
    { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
    },
  },
  -- }}}
}
