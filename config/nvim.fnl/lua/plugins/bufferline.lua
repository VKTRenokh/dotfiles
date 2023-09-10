-- [nfnl] Compiled from fnl/plugins/bufferline.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local uu = autoload("config.util")
local function _2_(_, opts)
  local bufferline = autoload("bufferline")
  bufferline.setup(opts)
  uu.keymap("n", "<S-Tab>", "<cmd>:tabprev<cr>")
  return uu.keymap("n", "<Tab>", "<cmd>:tabnext<cr>")
end
return uu.tx("akinsho/bufferline.nvim", {keys = {{"te", "<cmd>:tabedit<cr>", desc = "Create New Tab"}}, opts = {options = {mode = "tabs", separator_style = "thin", highlights = {background = {fg = "#616161"}, buffer_selected = {fg = "#f1f1f1", italic = true, bold = false}}, color_icons = false, always_show_bufferline = false, show_buffer_close_icons = false}}, config = _2_})
