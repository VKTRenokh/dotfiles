return {
  -- {{{ mini.pairs
  {
    "nvim-mini/mini.pairs",
    event = "LazyFile",
    enabled = false,
    opts = {
      modes = { insert = true, command = true, terminal = false },
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      skip_ts = { "string" },
      skip_unbalanced = true,
      markdown = true,
    },
    keys = {
      {
        "<leader>up",
        function()
          vim.g.minipairs_disable = not vim.g.minipairs_disable

          require("config.functions").notify(
            (vim.g.minipairs_disable and "Disabled" or "Enabled") .. " " .. "mini.pairs"
          )
        end,
      },
    },
  },
  -- ----------------------------------------------------------------------- }}}
  -- {{{ mini.surround

  {
    "nvim-mini/mini.surround",
    keys = {
      { "sa", mode = { "v", "n" },                    desc = "Add surrounding" },
      { "sd", desc = "Delete surrounding" },
      { "sh", desc = "Highlight closest surrounding" },
      { "sr", mode = { "v", "n" },                    desc = "Replace surrounding" },
      { "sn", desc = "Update surroundings in n_lines" },
    },
    opts = {
      mappings = {
        find = "",
        find_left = "",
      },
    },
  },
  -- }}}
  -- {{{ mini.ai - better vim a/i motions
  {
    "nvim-mini/mini.ai",
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
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),       -- class
          -- t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
          d = { "%f[%d]%d+" },                                                          -- digits
          e = {                                                                         -- Word with case
            {
              "%u[%l%d]+%f[^%l%d]",
              "%f[%S][%l%d]+%f[^%l%d]",
              "%f[%P][%l%d]+%f[^%l%d]",
              "^[%l%d]+%f[^%l%d]",
            },
            "^().*()$",
          },
          u = ai.gen_spec.function_call(),                           -- u for "Usage"
          U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
        },
      }
    end,
  },
  -- }}}
  -- {{{ flash.nvim
  {
    "folke/flash.nvim",
    event = "LazyFile",
    enabled = true,
    opts = {},
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "o", "x" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },
  -- }}}
  -- {{{ nvim-ts-autotag
  {
    "windwp/nvim-ts-autotag",
    event = "LazyFile",
    opts = {},
  },
  -- }}}
  -- {{{ nvim-autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {}
  },
  -- }}}
}
