-- [nfnl] Compiled from fnl/plugins/lualine.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local uu = autoload("config.util")
local _local_2_ = autoload("config.constants")
local icons = _local_2_["icons"]
local function hide_in_width()
  return (vim.fn.winwidth(0) > 80)
end
local function fg(name)
  local function _3_()
    local hl = vim.api.nvim_get_hl_by_name(name, true)
    return ((hl and hl.foreground) and {fg = string.format("#%06x", hl.foreground)})
  end
  return _3_
end
local function spaces()
  return ("spaces " .. vim.api.nvim_buf_get_option(0, "shiftwidth"))
end
local function progress()
  local current_line = vim.fn.line(".")
  local total_lines = vim.fn.line("$")
  local chars = {"\226\150\129\226\150\129", "\226\150\130\226\150\130", "\226\150\131\226\150\131", "\226\150\132\226\150\132", "\226\150\133\226\150\133", "\226\150\134\226\150\134", "\226\150\135\226\150\135", "\226\150\136\226\150\136"}
  local line_ratio = (current_line / total_lines)
  local index = math.ceil((line_ratio * #chars))
  return chars[index]
end
local function spaces0()
  return ("spaces:" .. vim.api.nvim_buf_get_option(0, "shiftwidth"))
end
local disabled = {"dashboard", "lazy", "NvimTree", "Outline", "alpha"}
local function _4_(str)
  return string.lower(str)
end
local function _5_()
  return ((((autoload("noice")).api).status).command).get()
end
local function _6_()
  return (package.loaded.noice and ((((autoload("noice")).api).status).command).has())
end
local function _7_()
  return ((((autoload("noice")).api).status).mode).get()
end
local function _8_()
  return (package.loaded.noice and ((((autoload("noice")).api).status).mode).has())
end
return uu.tx("nvim-lualine/lualine.nvim", {event = "VeryLazy", opts = {options = {section_separators = {left = "\238\130\180", right = "\238\130\182"}, icons_enabled = true, component_separators = {left = "\238\130\185", right = "\238\130\189"}}, disable_filetypes = disabled, ignore_focus = {}, always_divide_middle = true, globalstatus = true, refresh = {statusline = 1000, tabline = 1000, winbar = 1000}, sections = {lualine_a = {{"mode", fmt = _4_}}, lualine_b = {{"branch", icons_enabled = true, icon = "\239\144\152"}}, lualine_c = {{"filename", file_status = true, path = 1}}, lualine_x = {{_5_, cond = _6_, color = fg("Statement")}, {_7_, cond = _8_, color = fg("Constant")}, {"diagnostics", sources = {"nvim_diagnostic"}, sections = {"error", "warn"}, symbols = {error = icons.diagnostics.Error, warn = icons.diagnostics.Warning, info = icons.diagnostics.Information, hint = icons.diagnostics.Hint}, colored = true, always_visible = true, update_in_insert = false}, {"diff", symbols = {added = icons.git.Add, modified = icons.git.Mod, removed = icons.git.Remove}, cond = hide_in_width, colored = false}, spaces0, "encoding", {"filetype", icons_enabled = true, icon = nil, colored = true}}, lualine_y = {{progress}}, lualine_z = {{"location", padding = 0}}}, inactive_sections = {lualine_a = {}, lualine_b = {}, lualine_c = {{"filename", file_status = true, path = 1}}, lualine_x = {"location"}, lualine_y = {}, lualine_z = {}}, tabline = {}, winbar = {}, inactive_winbar = {}, extensions = {"fugitive"}}})
