return {
  'nvim-lualine/lualine.nvim',
  config = function()
    local lualine = require "lualine"

    local hide_in_width = function()
      return vim.fn.winwidth(0) > 80
    end

    local diagnostics = {
      "diagnostics",
      sources = { "nvim_diagnostic" },
      sections = { "error", "warn", },
      symbols = { error = " ", warn = " " },
      colored = true,
      update_in_insert = false,
      always_visible = true,
    }

    local diff = {
      "diff",
      colored = false,
      symbols = { added = " ", modified = " ", removed = " " },
      cond = hide_in_width
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
      icon = "󰘬",
    }

    local location = {
      "location",
      padding = 0,
    }

    local progress = function()
      local current_line = vim.fn.line(".")
      local total_lines = vim.fn.line("$")
      local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
      local line_ratio = current_line / total_lines
      local index = math.ceil(line_ratio * #chars)
      return chars[index]
    end

    local spaces = function()
      return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
    end

    lualine.setup({
      options = {
        icons_enabled = true,
        theme = "solarized_dark",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disable_filetypes = { "dashboard", "NvimTree", "Outline" },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { mode },
        -- lualine_a = { branch, diagnostics},
        lualine_b = { branch },
        -- lualine_b = { mode },
        lualine_c = { {
          'filename',
          file_status = true,
          path = 0
        } },
        lualine_x = { diagnostics, diff, spaces, "encoding", filetype },
        lualine_y = { progress },
        lualine_z = { location },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { {
          'filename',
          file_status = true,
          path = 1
        } },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { 'fugitive' },
    })

    vim.cmd [[ set laststatus=3 ]]
  end
}
