return {
  'akinsho/nvim-bufferline.lua',
  config = function()
    local bufferline = require "bufferline"

    bufferline.setup({
      options = {
        mode = "tabs",
        separator_style = 'thin',
        always_show_bufferline = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
        color_icons = false,
        offsets = {
          {
            filetype = "NvimTree",
            text = "",
            text_align = "left",
            separator = false
          }

        }
      },
      highlights = {
        background = {
          fg = '#616161',
        },
        buffer_selected = {
          fg = '#f1f1f1',
          bold = false,
          italic = false,
        },
      },
    })

    vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
    vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})

  end
}
