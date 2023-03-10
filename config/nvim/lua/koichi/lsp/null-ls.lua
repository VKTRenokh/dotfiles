local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local formatting = null_ls.builtins.formatting
local code_actions = null_ls.builtins.code_actions
--[[ local diagnostics = null_ls.builtins.diagnostics ]]

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
  })
end

null_ls.setup({
  debug = false,
  sources = {
    --[[ formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }), ]]
    --[[ formatting.stylua, ]]
    --[[ diagnostics.eslint_d.with({ ]]
    --[[   diagnostics_format = '[eslint] #{m}\n(#{c})' ]]
    --[[ }), ]]
    --[[ diagnostics.eslint, ]]
    --[[ code_actions.eslint_d, ]]
    --[[ diagnostics.stylelint, ]]
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          lsp_formatting(bufnr)
        end,
      })
    end
  end,
})

vim.api.nvim_create_user_command("DisableLspFormatting", function()
  vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
end, { nargs = 0 })
