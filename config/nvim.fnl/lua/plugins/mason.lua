-- [nfnl] Compiled from fnl/plugins/mason.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local uu = autoload("config.util")
local _local_2_ = (autoload("config.constants")).ensure_installed
local mason = _local_2_["mason"]
local _local_3_ = autoload("config.constants")
local lua_ls = _local_3_["lua_ls"]
local function _4_(_, opts)
  do end (autoload("mason")).setup(opts)
  local mr = autoload("mason-registry")
  for _0, tool in ipairs(opts.ensure_installed) do
    local p = mr.get_package(tool)
    if not p:is_installed() then
      p:install()
    else
    end
  end
  return nil
end
local function _6_()
  return (autoload("lazyvim.util")).has("nvim-cmp")
end
local function _7_()
end
return {uu.tx("williamboman/mason.nvim", {opts = {ui = {border = "rounded", icons = {package_installed = "\226\151\141", package_pending = "\226\151\141", package_uninstalled = "\226\151\141"}}, log_level = vim.log.levels.INFO, max_concurrent_installers = 5, ensure_installed = mason}, cmd = "Mason", config = _4_}), uu.tx("neovim/nvim-lspconfig", {event = {"BufReadPre", "BufNewFile"}, dependencies = {{"folke/neoconf.nvim", cmd = "Neoconf", config = true}, {"folke/neodev.nvim", opts = {experimental = {pathStrict = true}}}, "mason.nvim", "williamboman/mason-lspconfig.nvim", {"hrsh7th/cmp-nvim-lsp", cond = _6_}, "SmiteshP/nvim-navic"}, opts = {diagnostics = {underline = true, virtual_text = {spacing = 4, prefix = "\226\151\143"}, severity_sort = true, update_in_insert = false}}, autoformat = true, format = {formatting_options = nil, timeout_ms = nil}, servers = {lua_ls = {settings = {Lua = lua_ls.Lua}}}, config = _7_})}
