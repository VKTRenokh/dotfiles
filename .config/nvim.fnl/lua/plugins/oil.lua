-- [nfnl] Compiled from fnl/plugins/oil.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local uu = autoload("config.util")
local function _2_(conf)
  return conf
end
local function _3_(_, opts)
  local oil = autoload("oil")
  return oil.setup(opts)
end
return uu.tx("stevearc/oil.nvim", {keys = {{"SF", "<cmd>lua require('oil').open_float()<cr>", desc = "Open floating oil"}, {"Sf", "<cmd>Oil<cr>", desc = "Open oil"}}, dependencies = {"nvim-tree/nvim-web-devicons"}, opts = {columns = {"icon", "permissions"}, buf_options = {buflisted = false}, keymaps = {["g?"] = "actions.show_help", ["<CR>"] = "actions.select", ["<C-s>"] = "actions.select_vsplit", ["<C-h>"] = "actions.select_split", ["<C-t>"] = "actions.select_tab", ["<C-p>"] = "actions.preview", ["<Esc>"] = "actions.close", ["<C-l>"] = "actions.refresh", ["<leader>"] = "actions.parent", ["`"] = "actions.cd", ["~"] = "actions.tcd", ["g."] = "actions.toggle_hidden", q = "actions.close", _ = "actions.open_cwd"}, float = {padding = 5, max_width = 0, max_height = 0, border = "rounded", win_options = {winblend = 10}, override = _2_}, win_options = {signcolumn = "yes"}, preview = {max_width = 0, min_width = {40, 0.4}, width = nil, mex_height = 0, height = nil, border = "rounded", win_options = {winblend = 0}}, view_options = {show_hidden = true}, default_file_explorer = false}, config = _3_, prompt_save_on_select_new_entry = false})
