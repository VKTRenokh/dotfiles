return {
  -- {{{ plenary
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
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
  -- {{{ Olical nfnl
  {
    "Olical/nfnl",
    ft = { "fennel" },
  },
  -- }}}
  -- {{{ pipka.nvim
  {
    dir = "/mnt/sda1/workspace/pipka.nvim",
    opts = {
      split = "below",
      ensure_installed = {
        "igor",
        "bogdan",
        "utia",
      },
    },
    keys = {
      { "<leader>P", "<cmd>Pipka<cr>" },
    },
    cmd = "Pipka",
  }, -- }}}
}
