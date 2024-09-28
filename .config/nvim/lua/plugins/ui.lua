Icons = require("config.constants").icons

return {
  -- {{{ alpha.nvim
  {
    "goolord/alpha-nvim",
    keys = {
      { "<leader>aa", "<cmd>Alpha<cr>", desc = "Open alpha" },
    },
    event = "VimEnter",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local logo = [[
       _______             ____   ____.__
       \      \   ____  ___\   \ /   /|__| _____
       /   |   \_/ __ \/  _ \   Y   / |  |/     \
      /    |    \  ___(  <_> )     /  |  |  Y Y  \
      \____|__  /\____ >____/ \___/   |__|__|_|  /
              \/                               \/
      ]]

      dashboard.section.header.val = vim.split(logo, "\n", {})
      dashboard.section.buttons.val = {
        dashboard.button("f", Icons.documents.Files .. " Find file", ":Telescope find_files <CR>"),
        dashboard.button("r", Icons.ui.History .. " Recent files", ":Telescope oldfiles <CR>"),
        dashboard.button("t", Icons.ui.List .. " Find text", ":Telescope live_grep <CR>"),
        dashboard.button(
          "c",
          Icons.ui.Gear .. " Config",
          ":lua require('config.functions').config_files() <cr>"
        ),
        dashboard.button("u", Icons.ui.CloudDownload .. " Update", ":Lazy update<CR>"),
        dashboard.button("q", Icons.ui.SignOut .. " Quit", ":qa<CR>"),
      }

      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end

      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.section.footer.opts.hl = "@keyword"
      dashboard.opts.opts.noautocmd = true
      return dashboard
    end,
    config = function(_, dashboard)
      require("alpha").setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = " Neovim loaded "
            .. stats.loaded
            .. "/"
            .. stats.count
            .. " plugins in "
            .. ms
            .. "ms"
            .. ""
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
  -- ----------------------------------------------------------------------- }}}
  -- {{{ bufferline.nvim
  {
    "akinsho/bufferline.nvim",
    enabled = true,
    keys = {
      { "te", "<cmd>:tabedit<cr>", desc = "Create new tab" },
      { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Cycle tabs forwards" },
      { "gt", "<cmd>BufferLinePick<cr>", desc = "Pick tab" },
      { "gT", "<cmd>BufferLinePickClose<cr>", desc = "Pick tab to close" },
      { "gtd", "<cmd>BufferLineClose<cr>", desc = "Close all tabs" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Cycle tabs backwards" },
      { "<C-Tab>", "<cmd>tablast<cr>", desc = "Jump to the last tab" },
      { "<C-S-Tab>", "<cmd>tabfirst<cr>", desc = "Jump to the first tab" },
      { "<leader>tp", "<cmd>BufferLineTogglePin<cr>", desc = "Pin tab" },
      { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
      { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
    },
    opts = {
      options = {
        mode = "tabs",
        separator_style = "thin",
        show_buffer_close_icons = false,
        show_close_icon = false,
        color_icons = true,
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        diagnostics_indicator = function(_, _, diag)
          local icons = Constants.icons.diagnostics
          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
            .. (diag.warning and icons.Warning .. diag.warning or "")
          return vim.trim(ret)
        end,
      },
      highlights = {
        buffer_selected = {
          italic = true,
          bold = false,
        },
      },
    },
  },
  -- ----------------------------------------------------------------------- }}}
  -- {{{ dressing
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },

  -- ----------------------------------------------------------------------- }}}
  -- {{{ gitsigns.nvim
  {
    "lewis6991/gitsigns.nvim",
    event = "LazyFile",
    keys = {
      { "<leader>SR", '<cmd>lua require "gitsigns".reset_hunk()<cr>' },
      { "<leader>SS", '<cmd>lua require "gitsigns".stage_hunk()<cr>' },
      { "<leader>Sd", "<cmd>Gitsigns diffthis HEAD<cr>" },
      { "<leader>Sh", '<cmd>lua require "gitsigns".undo_stage_hunk()<cr>' },
      { "<leader>Sj", '<cmd>lua require "gitsigns".next_hunk()<cr>' },
      { "<leader>Sk", '<cmd>lua require "gitsigns".prev_hunk()<cr>' },
      { "<leader>Sp", '<cmd>lua require "gitsigns".preview_hunk()<cr>' },
      { "<leader>Sr", '<cmd>lua require "gitsigns".reset_buffer()<cr>' },
    },
    version = false,
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signcolumn = true,
      numhl = true,
      linehl = false,
      word_diff = false,
      watch_gitdir = {
        interval = 1000,
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 1000,
        ignore_whitespace = false,
      },
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil,
      max_file_length = 40000,
      preview_config = {
        border = "rounded",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
    },
  },

  -- ----------------------------------------------------------------------- }}}
  -- {{{ indent-blankline.nvim
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "LazyFile",
    enabled = false, -- enable when plugin author fixes it
    keys = {
      { "<leader>di", "<Cmd>IBLToggle<cr>", desc = "Toggle indention guides" },
    },
    opts = {
      indent = { char = "" }, -- 
      scope = {
        show_start = false,
      },
    },
    main = "ibl",
  },
  -- ----------------------------------------------------------------------- }}}
  -- {{{ lualine.nvim
  {
    "nvim-lualine/lualine.nvim",
    event = "LazyFile",
    enabled = false,
    opts = function(_, opts)
      local hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end

      local function fg(name)
        return function()
          ---@type {foreground?:number}?
          local hl = vim.api.nvim_get_hl_by_name(name, true)
          return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
        end
      end

      local diagnostics = {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        sections = { "error", "warn" },
        symbols = {
          error = Icons.diagnostics.Error,
          warn = Icons.diagnostics.Warning,
          info = Icons.diagnostics.Information,
          hint = Icons.diagnostics.Hint,
        },
        colored = true,
        update_in_insert = false,
        always_visible = true,
      }

      local diff = {
        "diff",
        colored = true,
        symbols = { added = Icons.git.Add, modified = Icons.git.Mod, removed = Icons.git.Remove },
        cond = hide_in_width,
      }

      local mode = {
        "mode",
        fmt = function(str)
          return string.lower(str)
        end,
      }

      local filetype = {
        "filetype",
        icons_enabled = true,
        icon = nil,
        colored = true,
      }

      local branch = {
        "branch",
        icons_enabled = true,
        icon = Icons.git.Branch,
      }

      local location = {
        "location",
        padding = 0,
      }

      local progress = function()
        local current_line = vim.fn.line(".")
        local total_lines = vim.fn.line("$")
        local chars =
          { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
        local line_ratio = current_line / total_lines
        local index = math.ceil(line_ratio * #chars)
        return chars[index]
      end

      local spaces = function()
        return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
      end

      opts.options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = Icons.ui.SlashLeft, right = Icons.ui.SlashRight },
        section_separators = {
          left = Icons.ui.BigCircleSeparatorLeft,
          right = Icons.ui.BigCircleSeparatorRight,
        },
        disable_filetypes = { "dashboard", "lazy", "NvimTree", "Outline", "alpha" },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      }

      opts.sections = {
        lualine_a = { mode },
        lualine_b = { branch },
        lualine_c = {
          {
            "filename",
            file_status = true,
            path = 0,
          },
          { "aerial" },
        },
        lualine_x = {
          {
            function()
              return require("noice").api.status.command.get()
            end,
            cond = function()
              return package.loaded["noice"] and require("noice").api.status.command.has()
            end,
            color = fg("Statement"),
          },
          {
            function()
              return require("noice").api.status.mode.get()
            end,
            cond = function()
              return package.loaded["noice"] and require("noice").api.status.mode.has()
            end,
            color = fg("Constant"),
          },
          diagnostics,
          diff,
          spaces,
          "encoding",
          filetype,
        },
        lualine_y = { progress },
        lualine_z = { location },
      }

      opts.inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            "filename",
            file_status = true,
            path = 1,
          },
        },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      }

      opts.tabline = {}
      opts.winbar = {}
      opts.inactive_winbar = {}
      opts.extensions = { "fugitive" }
    end,
  },
  -- ----------------------------------------------------------------------- }}}
  -- {{{ markdown-perview.nvim
  {
    "iamcco/markdown-preview.nvim",
    cmd = "MarkdownPreview",
    config = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  -- ----------------------------------------------------------------------- }}}
  -- {{{ noice.nvim
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        progress = {
          view = false,
        },
        hover = {
          silent = true,
        },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = false,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "",
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = "msg_show",
            kind = "wmsg",
          },
          opts = { skip = true },
        },
      },
      presets = {
        bottom_search = true,
        long_message_to_split = true,
        lsp_doc_border = true,
      },
      cmdline_popup = {
        views = {
          row = "50%",
          col = "50%",
        },
        win_options = {
          winhighlight = "NormalFloat:NormalFloat, FloatBoarder:FloatBorder",
        },
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
  -- --------------------------------------------------- }}}
  -- {{{ nvim-notify
  {
    "rcarriga/nvim-notify",
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Dismiss notification",
      },
    },
    opts = {
      render = "wrapped-compact",
      stages = "static",
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
  },
  -- ----------------------------------------------------------------------- }}}
  -- {{{ nvim-web-devicons
  {
    "echasnovski/mini.icons",
    lazy = true,
    opts = {
      file = {
        [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
        ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
      },
      filetype = {
        dotenv = { glyph = "", hl = "MiniIconsYellow" },
      },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = {},
  },

  -------------------------------------------------------------------------- }}}}
  -- {{{ trouble.nvim

  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      --stylua: ignore start
      { "<leader>t", "<Cmd>Trouble diagnostics<cr>", desc = "Open trouble diagnostics", },
			{ "<leader>T", "<cmd>Trouble<cr>", desc = "Open trouble selection menu", },
      -- stylua: ignore end
      { "<leader>cl", "<cmd>Trouble lsp<cr>", desc = "Open trouble with lsp" },
    },
    opts = {
      use_diagnostic_signs = true,
      auto_jump = false,
      open_no_results = true,
      warn_no_results = false,
      focus = true,
      keys = {
        gb = {
          action = function(view)
            view:filter({ buf = 0 }, { toggle = true })
          end,
          desc = "Toggle Current Buffer Filter (trouble)",
        },
      },
    },
  },

  -- ----------------------------------------------------------------------- }}}
  -- {{{ tiny-inline-diagnostic.nvim
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LazyFile",
    enabled = false,
    config = function()
      vim.diagnostic.config({ virtual_text = false })

      require("tiny-inline-diagnostic").setup()
    end,
  }, -- }}}
  -- {{{ markdown.nvim
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" }, -- if you use the mini.nvim suite
    ft = "markdown",
  },
  -- }}}
}
