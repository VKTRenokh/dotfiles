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
    branch = 'main',
    enabled = true,
    build = function()
      local treesitter = require("nvim-treesitter")

      treesitter.update(nil, { summary = true })
    end,
    lazy = vim.fn.argc(-1) == 0,
    version = false,
    -- version = "v0.9.1",
    keys = {
      { "<c-space>", desc = "Increment selection" },
      { "<bs>",      desc = "Decrement selection", mode = "x" },
    },
    opts = {
      indent = { enable = true },
      highlight = { enable = true },
      folds = { enable = true },
      ensure_installed = Constants.ensure_installed.treesitter
    },

    opts_extends = { "ensure_installed" },
    config = function(_, opts)
      require("nvim-treesitter").setup(opts)

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("lazyvim_treesitter", { clear = true }),
        callback = function(ev)
          if vim.tbl_get(opts, "highlight", "enable") ~= false then
            pcall(vim.treesitter.start)
          end

          if vim.tbl_get(opts, "indent", "enable") ~= false then
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
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
        -- highlights.BlinkCmpMenu = { bg = "#1e2030" }
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
  -- {{{ rainbow-delimiters.nvim
  {
    "hiphish/rainbow-delimiters.nvim",
    event = "LazyFile",
    main = "rainbow-delimiters.setup",
    opts = {
      query = {
        [''] = "rainbow-parens",
        vue = "rainbow-script-only"
      }
    }
  }
  -- }}}
}
