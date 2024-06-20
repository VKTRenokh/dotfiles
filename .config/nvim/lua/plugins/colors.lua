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
      autotag = { enable = true, disable = { "xml" } },
      autoinstall = true,
      context_commenting = { enable = true, enable_autocmd = false },
      highlight = {
        enable = true,
        disable = Constants.disabled.treesitter,
        additional_vim_regex_highlighting = true,
      },
      textobjects = {
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
      rainbow = {
        enable = true,
        extended_mode = false,
        max_file_lines = nil,
        query = "rainbow-parens",
        -- colors = Constants.colors.rainbow,
      },
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
    end,

    dependencies = {
      "windwp/nvim-ts-autotag",
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
  -- {{{ rainbow-delimiters
  {
    "HiPhish/rainbow-delimiters.nvim",
    opts = {
      blacklist = {
        "vue",
        "html",
        "jsx",
        "tsx",
      },
    },
    enabled = true,
    event = "LazyFile",
    main = "rainbow-delimiters.setup",
  },
  -- }}}
  -- {{{ tokyonight.nvim
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    enabled = true,
    opts = {
      transparent = true,
      style = "moon",
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_colors = function(colors)
        local util = require("tokyonight.util")

        colors.border_highlight = util.darken(colors.blue7, 0.8)
      end,
      on_highlights = function(highlights, colors)
        local util = require("config.functions")

        local border_highlights =
          { "NoiceCmdlinePopupBorder", "TelescopePromptBorder", "TelescopePromptTitle" }

        util.each(border_highlights, util.set(highlights, fg(colors.border_highlight)))
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)

      vim.cmd.colorscheme("tokyonight")
    end,
  },
  -- ----------------------------------------------------------------------- }}}
  -- {{{ mini.hipatternsk
  {
    "echasnovski/mini.hipatterns",
    event = "LazyFile",
    opts = {},
    config = function(_, opts)
      require("mini.hipatterns").setup(opts)
    end,
  },
  -- ----------------------------------------------------------------------- }}}
  -- {{{ rose-pine
  {
    "https://github.com/rose-pine/neovim.git",
    name = "rose-pine",
    lazy = false,
    enabled = false,
    priority = 1000,
    opts = {
      variant = "dawn",
    },
    config = function(_, opts)
      require("rose-pine").setup(opts)

      vim.cmd.colorscheme("rose-pine")
    end,
  }, -- }}}
}
