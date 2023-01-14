M = {}
local status, _ = pcall(require, "lspconfig")
if (not status) then return end

M.server_capabilities = function()

  local active_clients = vim.lsp.get_active_clients()
  local active_client_map = {}

  for index, value in ipairs(active_clients) do
    active_client_map[value.name] = index
  end

  vim.ui.select(vim.tbl_keys(active_client_map), {
    prompt = "Select client:",
    format_item = function(item)
      return "capabilites for: " .. item
    end,
  }, function(choice)
    -- print(active_client_map[choice])
    print(vim.inspect(vim.lsp.get_active_clients()[active_client_map[choice]].server_capabilities.executeCommandProvider))
    vim.pretty_print(vim.lsp.get_active_clients()[active_client_map[choice]].server_capabilities)
  end)
end

require("vktr.lsp.mason")
require("vktr.lsp.handlers").setup()
require "vktr.lsp.null-ls"

local lspconfig = require "lspconfig"

lspconfig.tsserver.setup({})
lspconfig.volar.setup({})
lspconfig.pyright.setup({})
lspconfig.bashls.setup({})
