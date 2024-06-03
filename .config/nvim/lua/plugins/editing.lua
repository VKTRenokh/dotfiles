return {
  -- {{{ mini.pairs
  {
    "echasnovski/mini.pairs",
    event = "InsertEnter",
    keys = {
      {
        "<leader>up",
        function()
          vim.g.minipairs_disable = not vim.g.minipairs_disable

          require("config.functions").notify(
            (vim.g.minipairs_disable and "Disabled" or "Enabled") .. " " .. "mini.nvim"
          )
        end,
      },
    },
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
  -- {{{ mini.ai - better vim a/i motions
  {
    "echasnovski/mini.ai",
    event = "LazyFile",
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({ -- code block
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
          d = { "%f[%d]%d+" }, -- digits
          e = { -- Word with case
            {
              "%u[%l%d]+%f[^%l%d]",
              "%f[%S][%l%d]+%f[^%l%d]",
              "%f[%P][%l%d]+%f[^%l%d]",
              "^[%l%d]+%f[^%l%d]",
            },
            "^().*()$",
          },
          u = ai.gen_spec.function_call(), -- u for "Usage"
          U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
        },
      }
    end,
  },
  -- }}}
  -- {{{ nvim-snippasta
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
  }, -- }}}
}
