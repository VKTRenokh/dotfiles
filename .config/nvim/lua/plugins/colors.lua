Icons = require("config.constants").icons

-- {{{ Utils
---@param color string
local function fg(color)
  return { fg = color }
end
-- }}}

return {
  -- {{{ nvim-treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    event = "LazyFile",
    build = ":TSUpdate",
    -- version = "v0.9.1",
    keys = {
      { "<c-space>", desc = "Increment selection" },
      { "<bs>", desc = "Decrement selection", mode = "x" },
    },
    opts = {
      -- autopairs = { enable = true },
      autoinstall = true,
      context_commenting = { enable = true, enable_autocmd = false },
      highlight = {
        enable = true,
        disable = Constants.disabled.treesitter,
        additional_vim_regex_highlighting = true,
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]c"] = "@class.outer",
            ["]a"] = "@parameter.inner",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]C"] = "@class.outer",
            ["]A"] = "@parameter.inner",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[c"] = "@class.outer",
            ["[a"] = "@parameter.inner",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[C"] = "@class.outer",
            ["[A"] = "@parameter.inner",
          },
        },
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
          selection_modes = {},
          include_surrounding_whitespace = true,
        },
      },
      indent = { enable = false, disable = { "yml", "yaml" } },
      disable = { "latex" },
      ensure_installed = Constants.ensure_installed.treesitter,
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = "<nop>",
          node_decremental = "<bs>",
        },
      },
    },

    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)

      local parsers = require("nvim-treesitter.parsers").get_parser_configs()

      parsers.zql = {
        install_info = {
          url = "https://github.com/cmus-enjoyers/tree-sitter-zql",
          files = { "src/parser.c" },
          branch = "dev",
          generate_requires_npm = false,
          requires_generate_from_grammar = false,
        },
        filetype = "zql",
      }

      vim.filetype.add({
        extension = {
          zql = "zql",
        },
      })
    end,

    dependencies = {
      {
        "windwp/nvim-ts-autotag",
        config = function()
          require("nvim-ts-autotag").setup()
        end,
      },
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        config = function(_, opts)
          require("ts_context_commentstring").setup(opts)

          vim.g.skip_ts_context_commentstring_module = true
        end,
      },
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        init = function()
          -- PERF: no need to load the plugin, if we only need its queries for mini.ai
          local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
          local opts = require("lazy.core.plugin").values(plugin, "opts", false)
          local enabled = false
          if opts.textobjects then
            for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
              if opts.textobjects[mod] and opts.textobjects[mod].enable then
                enabled = true
                break
              end
            end
          end
          if not enabled then
            require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
          end
        end,
      },
    },
  },
  -- ----------------------------------------------------------------------- }}}
  -- {{{ tokyonight.nvim
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    enabled = true,
    opts = {
      transparent = true,
      style = "moon",
      dim_inactive = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_colors = function(colors)
        local util = require("tokyonight.util")

        colors.border_highlight = util.darken(colors.blue, 0.8)
      end,
      on_highlights = function(highlights, colors)
        local util = require("config.functions")

        local border_highlights =
          { "NoiceCmdlinePopupBorder", "TelescopePromptBorder", "TelescopePromptTitle" }

        util.each(border_highlights, util.set(highlights, fg(colors.border_highlight)))

        highlights["@tag.delimiter.vue"] = fg(colors.red)
        highlights.BlinkCmpMenu = { bg = "#1e2030" }
        highlights.Folded.bg = "none"
        highlights.WinSeparator = fg(colors.terminal_black)
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)

      vim.cmd.colorscheme("tokyonight")
    end,
  },
  -- ----------------------------------------------------------------------- }}}
  -- {{{ mini.hipatterns
  {
    "echasnovski/mini.hipatterns",
    event = "LazyFile",
    opts = function()
      local hl = require("mini.hipatterns")
      return {
        highlighters = {
          hex_color = hl.gen_highlighter.hex_color({ priority = 2000 }),
        },
      }
    end,
    config = function(_, opts)
      require("mini.hipatterns").setup(opts)
    end,
  },
  -- ----------------------------------------------------------------------- }}}
}
