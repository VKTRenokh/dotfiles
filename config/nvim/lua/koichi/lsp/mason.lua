local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

local status_ok_1, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_1 then
  return
end

local servers = {
  "cssls",
  "cssmodules_ls",
  "emmet_ls",
  "html",
  "jsonls",
  "lua_ls",
  "tsserver",
  "bashls",
  "clangd",
  "elmls",
}

local settings = {
  ui = {
    border = "rounded",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

mason.setup(settings)
mason_lspconfig.setup({
  ensure_installed = servers,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("koichi.lsp.handlers").on_attach,
    capabilities = require("koichi.lsp.handlers").capabilities,
  }

  server = vim.split(server, "@")[1]

  if server == "jsonls" then
    local jsonls_opts = require("koichi.lsp.settings.jsonls")
    opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
  end

  if server == "elmls" then
    local elmls_opts = {
      root_dir = require 'lspconfig/util'.root_pattern('elm.json'),
    }
    opts = vim.tbl_deep_extend("force", elmls_opts, opts)
    lspconfig.elmls.setup(opts)
    goto continue
  end

  if server == "sumneko_lua" then
    local n_status_ok, neo_dev = pcall(require, "neodev")
    if not n_status_ok then
      return
    end
    local sumneko_opts = require("koichi.lsp.settings.sumneko_lua")
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    neo_dev.setup({})
    lspconfig.sumneko_lua.setup(opts)
    goto continue
  end

  lspconfig[server].setup(opts)
  ::continue::
end
