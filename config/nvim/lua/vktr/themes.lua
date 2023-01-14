require("github-theme").setup {
  transparent = true,
}

require("rose-pine").setup {
  groups = {
    background = "none",
  }
}

require("tokyonight").setup {
  transparent = true,
  styles = {
    sidebars = "transparent",
    floats = "transparent"
  }
}


require("noirbuddy").setup {
  preset = 'miami-nights',
}

vim.cmd [[
  colorscheme rose-pine
  highlight Normal guibg=none
  highlight NonText guibg=none
]]
