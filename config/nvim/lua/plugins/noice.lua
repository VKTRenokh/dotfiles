return {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
    local noice = require "noice"

    local notify = require "notify"

    noice.setup({
      messages = {
        enable = false
      }
    })

    notify.setup({
      backround_colour = "#000001",
      render = 'compact',
      timeout = 2500,
      stages = "static"
    })
  end
}
