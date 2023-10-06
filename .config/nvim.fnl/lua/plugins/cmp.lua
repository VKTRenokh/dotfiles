-- [nfnl] Compiled from fnl/plugins/cmp.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local uu = autoload("config.util")
local _local_2_ = autoload("config.constants")
local icons = _local_2_["icons"]
local completion = _local_2_["completion"]
local function _3_(_, opts)
  local cmp = autoload("cmp")
  local luasnip = autoload("luasnip")
  local check_backspace
  local function _4_()
    local col = (vim.fn.col(".") - 1)
    return ((col == 0) or vim.fn.getline("."):sub(col, col):match("%s"))
  end
  check_backspace = _4_
  local comp = {completeopt = "menu,menuone,noselect", keyword_length = 1}
  local snippet
  local function _5_(args)
    return luasnip.lsp_expand(args.body)
  end
  snippet = {expand = _5_}
  local formatting
  local function _6_(entry, vim_item)
    vim_item.kind = string.format("%s", icons.kind[vim_item.kind])
    vim_item.menu = completion.source_mapping[entry.source.name]
    return vim_item
  end
  formatting = {fields = {"kind", "abbr", "menu"}, format = _6_}
  local confirm_opts = {behavior = cmp.ConfirmBehavior.Replace, select = false}
  local mapping
  local function _7_(fallback)
    if cmp.visible() then
      return cmp.select_prev_item()
    elseif luasnip.jumpable(( - 1)) then
      return luasnip.jump(( - 1))
    else
      return fallback()
    end
  end
  local function _9_(fallback)
    if cmp.visible() then
      return cmp.select_next_item()
    elseif luasnip.expandable() then
      return luasnip.expand()
    elseif luasnip.expand_or_jumpable() then
      return luasnip.expand_or_jump()
    elseif __fnl_global__check_2dbackspace() then
      return fallback()
    else
      return fallback()
    end
  end
  mapping = {["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}), ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(( - 2)), {"i", "c"}), ["<C-e>"] = cmp.mapping({c = cmp.mapping.close(), i = cmp.mapping.abort()}), ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(2), {"i", "c"}), ["<C-j>"] = cmp.mapping.select_next_item(), ["<C-k>"] = cmp.mapping.select_prev_item(), ["<C-y>"] = cmp.config.disable, ["<CR>"] = cmp.mapping.confirm({select = true}), ["<S-Tab>"] = cmp.mapping(_7_, {"i", "s"}), ["<Tab>"] = cmp.mapping(_9_, {"i", "s"})}
  local window = {completion = cmp.config.window.bordered(), documentation = cmp.config.window.bordered()}
  local experimental = {ghost_text = true}
  cmp.setup.filetype("gitcommit", {sources = cmp.config.sources({{name = "cmp_git"}}, {{name = "buffer"}})})
  cmp.setup.cmdline(":", {mapping = cmp.mapping.preset.cmdline(), sources = cmp.config.sources({{name = "path"}}, {{name = "cmdline"}})})
  cmp.setup.cmdline({"/", "?"}, {mapping = cmp.mapping.preset.cmdline(), sources = cmp.config.sources({{name = "buffer"}})})
  opts.completion = comp
  opts.snippet = snippet
  opts.formatting = formatting
  opts.confirm_opts = confirm_opts
  opts.sources = completion.sources
  opts.window = window
  opts.experimental = experimental
  opts.mapping = mapping
  return nil
end
local function _11_()
  return (require("luasnip.loaders.from_vscode")).lazy_load()
end
return {uu.tx("hrsh7th/nvim-cmp", {event = "InsertEnter", dependencies = {"hrsh7th/cmp-buffer", "hrsh7th/cmp-calc", "hrsh7th/cmp-cmdline", "hrsh7th/cmp-nvim-lua", "hrsh7th/cmp-nvim-lsp-document-symbol", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-path", "saadparwaiz1/cmp_luasnip"}, opts = _3_, version = false}), uu.tx("L3MON4D3/LuaSnip", {dependencies = {"rafamadriz/friendly-snippets", config = _11_}, opts = {history = true, delete_check_events = "TextChanged"}}), uu.tx("PaterJason/cmp-conjure", {ft = {"clojure", "scheme", "lisp", "cl", "timl", "fennel", "janet"}})}
