-- [nfnl] Compiled from fnl/plugins/treesitter.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local uu = autoload("config.util")
local disabled = {"html", "latex", "markdown"}
local ensure_installed = {"bash", "c", "cpp", "css", "dockerfile", "html", "javascript", "json", "lua", "markdown", "markdown_inline", "python", "query", "regex", "rust", "tsx", "typescript", "vim", "yaml"}
local rainbow = {"Orchid", "DodgerBlue", "Cornsilk", "Salmon", "LawnGreen", "Gold"}
local function _2_(_, opts)
  local config = autoload("nvim-treesitter.configs")
  return config.setup(opts)
end
local function _3_()
  local plugin = (((autoload("lazy.core.config")).spec).plugins)["nvim-treesitter"]
  local opts = (require("lazy.core.plugin")).values(plugin, "opts", false)
  local enabled = false
  if opts.textobjects then
    for _, mod in ipairs({"move", "select", "swap", "lsp_interop"}) do
      if (opts.textobjects[mod] and opts.textobjects[mod].enable) then
        enabled = true
        break
      else
      end
    end
  else
  end
  if not enabled then
    return (require("lazy.core.loader")).disable_rtp_plugin("nvim-treesitter-textobjects")
  else
    return nil
  end
end
local function _7_()
  return nil
end
return {uu.tx("nvim-treesitter/nvim-treesitter", {event = {"BufReadPost", "BufNewFile"}, build = ":TSUpdate", keys = {{"<c-space>", desc = "Increment selection"}, {"<bs>", desc = "Decrement selection"}}, opts = {autopairs = {enable = true}, autotag = {enable = true, disable = {"xml"}}, autoinstall = true, context_commenting = {enable = true, enable_autocmd = false}, highlight = {enable = true, disable = disabled, additional_vim_regex_highlighting = false}, indent = {enable = true, disable = {"yml", "yaml"}}, rainbow = {extended_mode = true, max_file_lines = nil, colors = rainbow, enable = false}, textobjects = {select = {enable = true, lookahead = true, keymaps = {af = "@function.inner", ac = "@class.outer", ic = "@class.inner"}}, selection_modes = {}, include_surrounding_whitespace = true}, disable = {"latex"}, ensure_installed = ensure_installed, setup = {}, incremental_selection = {enable = true, keymaps = {init_selection = "<C-space>", node_incremental = "<C-space>", scope_incremental = "<nop>", node_decremental = "<bs>"}}}, config = _2_, dependencies = {"windwp/nvim-ts-autotag", "mrjones2014/nvim-ts-rainbow", "JoosepAlviste/nvim-ts-context-commentstring", {"nvim-treesitter/nvim-treesitter-textobjects", opts = {}, init = _3_, config = _7_}}, version = false}), uu.tx("mrjones2014/nvim-ts-rainbow", {event = {"BufReadPost", "BufNewFile"}})}
