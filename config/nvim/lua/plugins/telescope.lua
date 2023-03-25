return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-telescope/telescope-file-browser.nvim',
    "nvim-lua/plenary.nvim",
  },

  config = function()
    local telescope = require "telescope"
    local actions = require('telescope.actions')
    local builtin = require("telescope.builtin")

    local function telescope_buffer_dir()
      return vim.fn.expand('%:p:h')
    end

    local fb_actions = telescope.extensions.file_browser.actions

    telescope.setup {
      defaults = {
        theme = "ivy",
        prompt_prefix = "   ",
        mappings = {
          n = {
            ["q"] = actions.close
          },
        },
      },
      extensions = {
        file_browser = {
          theme = "ivy",
          hijack_netrw = false,
          hidden = true,
          grouped = true,
          quiet = true,
          respect_gitignore = false,
          -- auto_depth = 2,
          git_status = false,
          layout_strategy = "horizontal",
          layout_config = {
              horizontal = {
                prompt_position = "bottom",
                preview_width = 0.55,
                results_width = 0.8,
              },
              vertical = {
                mirror = false,
              },
              width = function(_, cols, _)
                if cols > 200 then
                  return 170
                else
                  return math.floor(cols * 0.87)
                end
              end,
              height = 0.80,
              preview_cutoff = 120,
            },
            border = {},
            borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          mappings = {
            -- your custom insert mode mappings
            ["i"] = {
              ["<C-w>"] = function() vim.cmd('normal vbd') end,
            },
            ["n"] = {
              -- your custom normal mode mappings
              ["N"] = fb_actions.create,
              ["h"] = fb_actions.goto_parent_dir,
              ["/"] = function()
                vim.cmd('startinsert')
              end
            },
          },
        },
      },
    }

    telescope.load_extension("file_browser")

    vim.keymap.set('n', ';f',
      function()
        builtin.find_files({
          hidden = true
        })
      end)
    vim.keymap.set('n', ';r', function()
      builtin.live_grep()
    end)
    vim.keymap.set('n', '\\\\', function()
      builtin.buffers()
    end)
    vim.keymap.set('n', ';t', function()
      builtin.help_tags()
    end)
    vim.keymap.set('n', ';;', function()
      builtin.resume()
    end)
    vim.keymap.set('n', ';e', function()
      builtin.diagnostics()
    end)
    vim.keymap.set("n", "sf", function()
      telescope.extensions.file_browser.file_browser({
        path = "%:p:h",
        cwd = telescope_buffer_dir(),
        respect_gitignore = false,
        --[[ hidden = true, ]]
        --[[ grouped = true, ]]
        --[[ previewer = false, ]]
        initial_mode = "normal",
        --[[ layout_config = { height = 40 } ]]
      })
    end)
  end
}
