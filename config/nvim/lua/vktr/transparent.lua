local statusOk, transparent = pcall(require, "transparent")

if not statusOk then return end

transparent.setup({
  enable = true, -- boolean: enable transparent
  extra_groups = "all", -- table/string: additional groups that should be cleared
  exclude = { "lualine_a_command",
    "lualine_a_insert",
    "lualine_a_normal",
    "lualine_a_visual",
    --    "CursorLine",
    "FloatBorder",
    "Visual"
  }, -- table: groups you don't want to clear
})
