-- [nfnl] Compiled from fnl/plugins/telescope.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("config.util")
local tx = _local_2_["tx"]
local _local_3_ = autoload("config.constants")
local icons = _local_3_["icons"]
local function _4_(_, opts)
  return (require("telescope")).setup(opts)
end
local function _5_()
  local telescope = autoload("telescope")
  local fb_actions = telescope.extensions.file_browser.actions
  local function _6_()
    return vim.cmd("normal vbd")
  end
  local function _7_()
    return vim.cmd("startinsert")
  end
  telescope.setup({extensions = {file_browser = {theme = "dropdown"}, hijack_netrw = true, mappings = {i = {["<C-w>"] = _6_}, n = {N = fb_actions.create, h = fb_actions.goto_parent_dir, ["/"] = _7_}}}})
  return telescope.load_extension("file_browser")
end
return {tx("nvim-telescope/telescope.nvim", {cmd = "Telescope", keys = {{";f", "<cmd> lua require('telescope.builtin').find_files({ hidden = true}) <CR>"}, {";g", "<cmd> lua require('telescope.builtin').git_commits() <cr>"}, {";r", "<cmd> lua require('telescope.builtin').live_grep() <cr>"}, {"\\\\", "<cmd> lua require('telescope.builtin').buffers() <cr>"}, {";t", "<cmd> lua require('telescope.builtin').help_tags() <cr>"}, {";;", "<cmd> lua require('telescope.builtin').resume() <cr>"}, {";e", "<cmd> lua require('telescope.builtin').diagnostics() <cr>"}, {";b", "<cmd> lua require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({ winblend = 10, previewer = false}))<cr>"}, {"sf", "<cmd> lua require('telescope').extensions.file_browser.file_browser({ path = '%:p:h', cwd = vim.fn.expand('%:p:h'), respect_gitignore = false, hidden = true, grouped = true, previewer = false, initial_mode = 'normal', layout_config = { prompt_position = 'top', height = 50}, layout_strategy = 'horizontal'}) <cr>"}}, dependencies = {"nvim-lua/plenary.nvim", "nvim-telescope/telescope-file-browser.nvim"}, opts = {defaults = {layout_config = {prompt_position = "top"}, layout_strategy = "horizontal", prompt_prefix = icons.ui.Telescope, sorting_strategy = "ascending", winblend = 10}, pickers = {colorscheme = {enable_preview = true}}}, config = _4_, version = false}), tx("nvim-telescope/telescope-file-browser.nvim", {dependencies = {"nvim-telescope/telescope.nvim"}, config = _5_})}
