return {
  -- {{{ nvim-autopairs
  {
    "echasnovski/mini.pairs",
    event = "InsertEnter",
    opts = {},
  },
  -- ----------------------------------------------------------------------- }}}
  -- {{{ nvim-surround
  {
    "kylechui/nvim-surround",
    keys = {
      "<C-g>s",
      "<C-g>S",
      "ys",
      "yss",
      { "yS", mode = { "n", "v", "x" } },
      "ySS",
      { "S", mode = { "n", "v", "x" } },
      "gS",
      "ds",
      "cs",
      "cS",
    },
    config = function(_, opts)
      require("nvim-surround").setup(opts)
    end,
  },
  -- }}}
  -- {{{ Mini.ai - better vim a/i motions
  { "https://github.com/echasnovski/mini.ai", event = "LazyFile" },
  -- }}}
  {
    "mfussenegger/nvim-snippasta",
    keys = {
      {
        "<leader>p",
        function()
          require("snippasta").paste()
        end,
      },
      {
        "<Tab>",
        function()
          vim.snippet.jump(1)
        end,
        noremap = true,
        mode = { "i" },
      },
    },
  },
}
