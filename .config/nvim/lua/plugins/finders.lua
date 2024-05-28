Constants = require("config.constants")

return {
  -- {{{ Telescope
  {
    "nvim-telescope/telescope.nvim",
    keys = { -- {{{
      -- stylua: ignore
			{ ";f", function() require("telescope.builtin").find_files({ hidden = true }) end, desc = "Find files" },
      -- stylua: ignore
			{ ";g", function() require("telescope.builtin").git_commits() end, desc = "Show git commits" },
      -- stylua: ignore
			{ ";r", function() require("telescope.builtin").live_grep() end, desc = "Find text in files" },
      -- stylua: ignore
			{ "\\\\", function() require("telescope.builtin").buffers() end, desc = "Show all buffers" },
      -- stylua: ignore
			{ ";t", function() require("telescope.builtin").help_tags() end, desc = "Show helps" },
      -- stylua: ignore
			{ ";;", function() require("telescope.builtin").resume() end, desc = "Open last telescope" },
      -- stylua: ignore
			{ ";e", function() require("telescope.builtin").diagnostics() end, desc = "Find errors" },
      {
        ";F",
        function()
          require("telescope.builtin").current_buffer_fuzzy_find(
            require("telescope.themes").get_dropdown({ winblend = 10, previewer = false })
          )
        end,
        desc = "Current Buffer Fuzzy",
      },
      { "<leader>LS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>" },
      { "<leader>Ls", "<cmd>Telescope lsp_document_symbols<cr>" },
      -- stylua: ignore
			{ "gD", function() vim.lsp.buf.declaration() end, desc = "Goto Definition", },
      { "gd", "<Cmd>Telescope lsp_definitions<cr>", desc = "References" },
      { "gr", "<Cmd>Telescope lsp_references<cr>", desc = "references" },
      { "gK", "<Cmd>Telescope lsp_implementations<cr>", desc = "lsp implementations" },
      { "gt", "<Cmd>Telescope lsp_type_definitions<cr>", desc = "Lsp type defenetions" },
      { ";n", "<Cmd>Telescope notify<cr>", desc = "Find Notifications" },
    }, -- }}}
    cmd = "Telescope",
    version = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = function()
      local actions = require("telescope.actions")

      return {
        defaults = {
          layout_config = { prompt_position = "top" },
          layout_strategy = "horizontal",
          prompt_prefix = Constants.icons.ui.Telescope,
          selection_caret = "󱞩 ",
          sorting_strategy = "ascending",

          mappings = {
            ["n"] = {
              ["<C-e>"] = actions.select_vertical,
              ["<C-v>"] = actions.select_horizontal,
              ["<C-t>"] = actions.select_tab,
            },
            ["i"] = {
              ["<C-e>"] = actions.select_vertical,
              ["<C-v>"] = actions.select_horizontal,
              ["<C-t>"] = actions.select_tab,
            },
          },
        },
      }
    end,
  },
  -- ----------------------------------------------------------------------- }}}
  -- {{{ Telescope file browser
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
      {
        "sf",
        function()
          require("telescope").extensions.file_browser.file_browser({
            path = "%:p:h",
            cwd = vim.fn.expand("%:p:h"),
            respect_gitignore = false,
            hidden = true,
            grouped = true,
            previewer = false,
            initial_mode = "normal",
            layout_config = { prompt_position = "top", height = 60 },
          })
        end,
        desc = "File browser",
      },
    },
    config = function()
      local telescope = require("telescope")
      local fb_actions = require("telescope").extensions.file_browser.actions
      telescope.setup({
        extensions = {
          file_browser = {
            theme = "dropdown",
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            mappings = {
              -- your custom insert mode mappings
              ["i"] = {
                ["<C-w>"] = function()
                  vim.cmd("normal vbd")
                end,
              },
              ["n"] = {
                -- your custom normal mode mappings
                ["N"] = fb_actions.create,
                ["h"] = fb_actions.goto_parent_dir,
                ["/"] = function()
                  vim.cmd("startinsert")
                end,
              },
            },
          },
        },
      })
      telescope.load_extension("file_browser")
    end,
  },
  -- ----------------------------------------------------------------------- }}}
}
