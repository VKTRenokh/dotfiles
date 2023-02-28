return {
  'kyazdani42/nvim-web-devicons',
  config = function()
    local icons = require 'nvim-web-devicons'

    icons.setup {
      override = {},
      default = true
    }
  end
}
