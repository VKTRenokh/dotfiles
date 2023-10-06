-- [nfnl] Compiled from fnl/plugins/utils.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("config.util")
local tx = _local_2_["tx"]
local function _3_(_, opts)
  return (require("neoscroll")).setup(opts)
end
return {tx("tpope/vim-fugitive", {dependencies = {"tpope/vim-rhubarb"}, keys = {{"<leader>g", "<cmd>G<cr>", desc = "Open vim fugitive"}}}), tx("karb94/neoscroll.nvim", {keys = {"zt", "zz", "zb", "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>"}, opts = {mappings = {"zt", "zz", "zb", "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>"}}, config = _3_}), tx("akinsho/toggleterm.nvim", {cmd = "ToggleTerm", version = "*", opts = {size = 13, open_mapping = "<c-\\>", shade_filetypes = {}, shade_terminals = true, shading_factor = 1, start_in_insert = true, persist_size = true, direction = "horizontal"}})}
