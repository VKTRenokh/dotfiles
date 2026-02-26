Icons = require("config.constants").icons

return {
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
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
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
      current_line_blame = true,
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
  -- {{{ mini.icons
  {
    "nvim-mini/mini.icons",
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
  -------------------------------------------------------------------------- }}}}
  -- {{{ trouble.nvim

  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      --stylua: ignore start
      { "<leader>t",  "<Cmd>Trouble diagnostics<cr>", desc = "Open trouble diagnostics", },
      { "<leader>T",  "<cmd>Trouble<cr>",             desc = "Open trouble selection menu", },
      -- stylua: ignore end
      { "<leader>cl", "<cmd>Trouble lsp<cr>",         desc = "Open trouble with lsp" },
    },
    opts = {
      use_diagnostic_signs = true,
      auto_jump = false,
      open_no_results = true,
      presets = {
        modes = {
          lsp = {
            win = { position = "right" },
          },
        },
      },
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
  -- {{{ snacks.nvim
  {
    "folke/snacks.nvim",
    priority = 1000,
    enabled = true,
    lazy = false,
    keys = {
      -- stylua: ignore start
      { ";f",         function() Snacks.picker.files({ hidden = true }) end },
      { ";F",         function() Snacks.picker.files({ hidden = true, ignored = true }) end },
      { ";r",         function() Snacks.picker.grep() end },
      { ";e",         function() Snacks.picker.diagnostics() end },
      { "gd",         function() Snacks.picker.lsp_definitions() end,                       desc = "Goto Definition" },
      { "gD",         function() Snacks.picker.lsp_declarations() end,                      desc = "Goto Declaration" },
      { "grr",        function() Snacks.picker.lsp_references() end,                        nowait = true,                  desc = "References" },
      { "gri",        function() Snacks.picker.lsp_implementations() end,                   desc = "Goto Implementation" },
      { "gy",         function() Snacks.picker.lsp_type_definitions() end,                  desc = "Goto T[y]pe Definition" },
      { ";s",         function() Snacks.picker.lsp_symbols() end,                           desc = "LSP Symbols" },
      { ";S",         function() Snacks.picker.lsp_workspace_symbols() end,                 desc = "LSP Workspace Symbols" },

      { ";gb",        function() Snacks.picker.git_branches() end,                          desc = "Git Branches" },
      { ";g",         function() Snacks.picker.git_log() end,                               desc = "Git Log" },
      { ";gs",        function() Snacks.picker.git_status() end,                            desc = "Git Status" },
      { "<leader>gS", function() Snacks.picker.git_stash() end,                             desc = "Git Stash" },
      { ";gd",        function() Snacks.picker.git_diff() end,                              desc = "Git Diff (Hunks)" },
      { "<leader>gf", function() Snacks.picker.git_log_file() end,                          desc = "Git Log File" },
      { "<leader>ex", function() Snacks.picker.explorer() end,                              desc = "Explorer" },

      { ";t",         function() Snacks.picker.help() end,                                  desc = "Help Pages" },

      -- stylua: ignore end
    },
    opts = {
      bigfile = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = false },
      dashboard = {
        enabled = true,
        preset = {
          -- stylua: ignore start
          -- https://patorjk.com/software/taag/#p=testall&f=Alpha&t=zxc
          header = [[
       ,----,
     .'   .`|,--,  ,--,
  .'   .'  .'|'. \/ .`|    ,---.
,---, '   ./ '  \/  / ;   /     \
;   | .'  /   \  \.' /   /    / '
`---' /  ;--,  \  ;  ;  .    ' /
  /  /  / .`| / \  \  \ '   ; :__
./__;     .'./__;   ;  \'   | '.'|
;   |  .'   |   :/\  \ ;|   :    :
`---'       `---'  `--`  \   \  /
                          `----'
]],
          -- stylua: ignore end
          keys = {
            {
              icon = " ",
              key = "f",
              desc = "Find File",
              action = ":lua Snacks.dashboard.pick('files')",
            },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            {
              icon = " ",
              key = "g",
              desc = "Find Text",
              action = ":lua Snacks.dashboard.pick('live_grep')",
            },
            {
              icon = " ",
              key = "r",
              desc = "Recent Files",
              action = ":lua Snacks.dashboard.pick('oldfiles')",
            },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action =
              ":cd ~/.config/nvim | :lua Snacks.dashboard.pick('files')",
            },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            {
              icon = "󰒲 ",
              key = "L",
              desc = "Lazy",
              action = ":Lazy",
              enabled = package.loaded.lazy ~= nil,
            },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
      words = { enabled = false },
      input = { enabled = true },
      scoped = { enabled = true },
    },
  },
  -- }}}
  -- {{{ indent-blankline.nvim
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "LazyFile",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
  },
  -- }}}
  -- {{{ fidget.nvim
  {
    "j-hui/fidget.nvim",
    event = "LazyFile",
    opts = {
      -- options
      notification = {
        override_vim_notify = true,
      },
    },
  },
  -- }}}
  -- {{{ tiny inline diagnostic
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LazyFile",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup()
      vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
    end,
  },
  -- }}}
  -- {{{ tiny-glimmer.nvim
  {
    "rachartier/tiny-glimmer.nvim",
    event = 'LazyFile',
    priority = 10,
    opts = {
      enabled = true,

      disable_warnings = true,

      refresh_interval_ms = 8,

      overwrite = {
        auto_map = true,

        yank = {
          enabled = true,
          default_animation = "LazyFile",
        },

        search = {
          enabled = true,
          default_animation = "pulse",
          next_mapping = "n",
          prev_mapping = "N",
        },

        paste = {
          enabled = true,
          default_animation = "reverse_fade",
          paste_mapping = "p",
          Paste_mapping = "P",
        },

        undo = {
          enabled = true,
          default_animation = {
            name = "fade",
            settings = {
              from_color = "DiffDelete",
              max_duration = 500,
              min_duration = 500,
            },
          },
          undo_mapping = "u",
        },

        -- Redo operation animation
        redo = {
          enabled = true,
          default_animation = {
            name = "fade",
            settings = {
              from_color = "DiffAdd",
              max_duration = 500,
              min_duration = 500,
            },
          },
          redo_mapping = "<c-r>",
        },
      },
    },
    config = function(_, opts)
      require('tiny-glimmer').setup(opts)
    end
  }
  -- }}}
}
