require("github-theme").setup {
  transparent = true,
}

require("rose-pine").setup {
  disable_italics = true,
  disable_background = true
}

require("tokyonight").setup {
  transparent = true,
  styles = {
    sidebars = "transparent",
    floats = "transparent"
  }
}


-- require("noirbuddy").setup {
--   preset = 'miami-nights',
-- }
require("nebulous").setup {
  variant = "midnight",
  disable = {
    background = true,
    endOfBuffer = false,
    terminal_colors = false,
  },
  italic = {
    comments  = false,
    keywords  = false,
    functions = false,
    variables = false,
  },
}

require('poimandres').setup {
  bold_vert_split = false, -- use bold vertical separators
  dim_nc_background = false, -- dim 'non-current' window backgrounds
  disable_background = true, -- disable background
  disable_float_background = true, -- disable background for floats
  disable_italics = true, -- disable italics
}

require("bluloco").setup({
  style = "auto", -- "auto" | "dark" | "light"
  transparent = true,
})


if vim.v.argv[3] then
  vim.cmd("colorscheme " .. vim.v.argv[3])
  vim.cmd [[
    highlight Normal guibg=none
    highlight NonText guibg=none
  ]]
else
  vim.cmd [[
    colorscheme bluloco
    highlight Normal guibg=none
    highlight NonText guibg=none
  ]]
end
