-- [nfnl] Compiled from lualine.fnl by https://github.com/Olical/nfnl, do not edit.
local uu = require("vktrenokh.util")
local function hide_in_width()
  return (vim.fn.winwidth(0) > 80)
end
local function fg(name)
  local function _1_()
    local hl = vim.api.nvim_get_hl_by_name(name, true)
    return ((hl and hl.foreground) and {fg = string.format("#%06x", hl.foreground)})
  end
  return _1_
end
local function progress()
  local current_line = vim.fn.line(".")
  local total_lines = vim.fn.line("$")
  local chars = {"\226\150\129\226\150\129", "\226\150\130\226\150\130", "\226\150\131\226\150\131", "\226\150\132\226\150\132", "\226\150\133\226\150\133", "\226\150\134\226\150\134", "\226\150\135\226\150\135", "\226\150\136\226\150\136"}
  local line_ratio = (current_line / total_lines)
  local index = math.ceil((line_ratio * #chars))
  return chars[index]
end
local function spaces()
  return ("spaces:" .. vim.api.nvim_buf_get_option(0, "shiftwidth"))
end
local disabled = {"dashboard", "lazy", "NvimTree", "Outline", "alpha"}
local function _2_(str)
  return string.lower(str)
end
return uu.tx("nvim-lualine/lualine.nvim", {event = "VeryLazy", opts = {options = {section_separators = {left = "\238\130\180", right = "\238\130\182"}, icons_enabled = true, component_separators = {left = "\238\130\185", right = "\238\130\189"}}, disable_filetypes = disabled, ignore_focus = {}, always_divide_middle = true, globalstatus = true, refresh = {statusline = 1000, tabline = 1000, winbar = 1000}, sections = {lualine_a = {{"mode", fmt = _2_}}, lualine_b = {{"branch", icons_enabled = true, icon = "\239\144\152"}}, lualine_c = {{"filename", file_status = true, path = 1}}, lualine_y = {{progress}}, lualine_z = {{"location", padding = 0}}}}})
