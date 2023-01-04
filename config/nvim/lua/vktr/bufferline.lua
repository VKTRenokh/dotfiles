local status, bufferline = pcall(require, "bufferline")
if (not status) then return end

bufferline.setup({
  options = {
    mode = "tabs",
    separator_style = 'block',
    always_show_bufferline = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
    color_icons = false
  },
  highlights = {
    separator = {
      fg = "#000000",
      --      bg = '#002b36'
      bg = "#000000",
    },
    separator_selected = {
      fg = "#000000",
    },
    background = {
      fg = "#000000",
      bg = "#000000"
    },
    buffer_selected = {
      fg = "#000000",
      bold = false,
    },
    fill = {
      bg = "#000000"
    }
  },
})

vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})
