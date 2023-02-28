return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'windwp/nvim-ts-autotag',
    'p00f/nvim-ts-rainbow',
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  build = ':TSUpdate',
  config = function()
    local ts = require 'nvim-treesitter.configs'

    ts.setup {
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
        disable = {},
      },
      auto_install = true,
      ensure_installed = {
        'tsx',
        'lua',
        'json',
        'css',
        'html',
      },
      autotag = {
        enable = true,
      },
      rainbow = {
        enable = true,
        -- disable = { "jsx", "cpp" },
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        -- colors = {},
        -- termcolors = {}
      }
    }
  end
}
