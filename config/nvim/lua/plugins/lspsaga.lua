return {
  'glepnir/lspsaga.nvim',
  event = "BufRead",
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    local saga = require 'lspsaga'
    saga.setup({
      ui = {
        border = 'rounded',
        expand = '',
        collapse = '',
        preview = ' ',
        code_action = '💡',
        diagnostic = '🐞',
        incoming = ' ',
        outgoing = ' ',
        colors = {
          normal_bg = '#002b36'
        }
      },
      finder = {
        edit = { 'o', '<CR>' },
        vsplit = 's',
        split = 'i',
        tabe = 't',
        quit = { 'q', '<ESC>' },
        open = "o",
      },
      lightbulb = {
        enable = true,
        enable_in_insert = true,
        sign = true,
        sign_priority = 40,
        virtual_text = true,
      },
      symbol_in_winbar = {
        enable = true,
        separator = '  ',
        hide_keyword = true,
        show_file = true,
        folder_level = 2,
        respect_root = true,
        color_mode = true,
      },
      show_outline = {
        win_position = 'right',
        win_width = 30,
        auto_enter = true,
        auto_preview = true,
        virt_text = '┃',
        auto_refresh = true,
      },
    })

    --[[   finder_icons = { ]]
    --[[     def = '  ', ]]
    --[[     ref = '諭 ', ]]
    --[[     link = '  ', ]]
    --[[   }, ]]

    local opts = { noremap = true, silent = true }
    vim.keymap.set('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
    vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
    vim.keymap.set('n', 'gh', '<Cmd>Lspsaga lsp_finder<CR>', opts)
    vim.keymap.set('n', 'gd', '<Cmd>Lspsaga goto_definition<CR>', opts)
    vim.keymap.set('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.keymap.set('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>', opts)
    vim.keymap.set('n', '<leader>r', '<Cmd>Lspsaga rename<CR>', opts)
    vim.keymap.set('n', '<leader>o', '<Cmd>Lspsaga outline<CR>', opts)
    vim.keymap.set('n', '<leader>ca', '<Cmd>Lspsaga code_action<CR>', opts)
  end
}
