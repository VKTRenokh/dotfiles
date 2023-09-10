-- [nfnl] Compiled from fnl/plugins/lspconfig.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("config.util")
local bkset = _local_2_["bkset"]
local vis_op_2b = _local_2_["vis-op+"]
local tx = _local_2_["tx"]
local _local_3_ = autoload("nfnl.core")
local merge = _local_3_["merge"]
local diagnostics = {severity_sort = true, underline = true, signs = true, virtual_text = false, update_in_insert = false}
local handlers = {["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, diagnostics), ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "single"}), ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = "single"})}
local function highlight_line_symbol()
  return vim.cmd("highlight! DiagnosticLineNrError guibg=#51202A guifg=#FF0000 gui=bold\n    highlight! DiagnosticLineNrWarn guibg=#51412A guifg=#FFA500 gui=bold\n    highlight! DiagnosticLineNrInfo guibg=#1E535D guifg=#00FFFF gui=bold\n    highlight! DiagnosticLineNrHint guibg=#1E205D guifg=#0000FF gui=bold\n    sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticLineNrError\n    sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticLineNrWarn\n    sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticLineNrInfo\n    sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticLineNrHint")
end
local function highlight_symbols(client, bufnr)
  if client.server_capabilities.documentHighlightProvider then
    highlight_line_symbol()
    vim.api.nvim_create_autocmd("ColorScheme", {buffer = bufnr, group = vim.api.nvim_create_augroup("HighlightColors", {clear = true}), callback = highlight_line_symbol})
    return vim.cmd("hi! link LspReferenceWrite TSConstMacro")
  else
    return nil
  end
end
local function _5_()
  vim.o.updatetime = 250
  return nil
end
local function _6_()
  local lsp = require("lspconfig")
  local lsp_util = require("lspconfig.util")
  local cmplsp = autoload("cmp_nvim_lsp")
  local _let_7_ = autoload("telescope.builtin")
  local lsp_references = _let_7_["lsp_references"]
  local lsp_implementations = _let_7_["lsp_implementations"]
  local mason = require("mason")
  local illuminate = require("illuminate")
  local on_attach
  local function _8_(client, b)
    highlight_symbols(client, b)
    client.server_capabilities.semanticTokensProvider = nil
    local function _9_()
      vim.lsp.buf.hover()
      return vim.lsp.buf.hover()
    end
    bkset("n", "<leader>h", _9_, {buffer = b, desc = "Show docs"})
    bkset("n", "gd", vim.lsp.buf.definition, {buffer = b, desc = "Go definition"})
    bkset("n", "gD", "<c-w><c-]><c-w>T", {buffer = b, desc = "Go definition new tab"})
    bkset("n", "<leader>tD", vim.lsp.buf.type_definition, {buffer = b, desc = "Type definition"})
    bkset({"i", "n"}, "<M-;>", vim.lsp.buf.signature_help, {buffer = b, desc = "Signiture help"})
    bkset({"i", "n"}, "<D-p>", vim.lsp.buf.signature_help, {buffer = b, desc = "Signiture help"})
    bkset("n", "<leader>rr", vim.lsp.buf.rename, {buffer = b, desc = "Rename"})
    bkset("n", "<leader>p", vim.diagnostic.open_float, {buffer = b, desc = "Preview diagnostics"})
    bkset("n", "<leader>re", vim.diagnostic.setloclist, {buffer = b, desc = "List diagnostics"})
    if not string.find(vim.api.nvim_buf_get_name(b), ".*.fnl$") then
      bkset("n", "=", ":lua vim.lsp.buf.format({async = true})<Cr>", {buffer = b, desc = "Apply formatting"})
      bkset("x", "=", vis_op_2b(vim.lsp.buf.format, {async = true}), {buffer = b, desc = "Apply formatting"})
    else
    end
    bkset("n", "[s", vim.diagnostic.goto_prev, {buffer = b, desc = "Goto prev erro"})
    bkset("n", "]s", vim.diagnostic.goto_next, {buffer = b, desc = "Goto next erro"})
    local function _11_()
      return lsp_references({jump_type = "never"})
    end
    bkset("n", "<leader>gr", _11_, {buffer = b, desc = "Go to references"})
    bkset("n", "<leader>gi", lsp_implementations, {buffer = b, desc = "Go to implementations"})
    bkset({"n", "x"}, "<C-r>", vim.lsp.buf.code_action, {buffer = b, desc = "Code actions"})
    return bkset({"n", "x"}, "<leader>ra", vim.lsp.buf.code_action, {buffer = b, desc = "Code actions"})
  end
  on_attach = _8_
  local capabilities = cmplsp.default_capabilities()
  local before_init
  local function _12_(params)
    params.workDoneToken = "1"
    return nil
  end
  before_init = _12_
  local default_map = {on_attach = on_attach, before_init = before_init, handlers = handlers, capabilities = cmplsp.default_capabilities()}
  capabilities.textDocument.foldingRange = {lineFoldingOnly = true, dynamicRegistration = false}
  mason.setup()
  illuminate.configure()
  local function _13_(client, b)
    on_attach(client, b)
    return highlight_line_symbol()
  end
  lsp.fennel_language_server.setup(merge(default_map, {settings = {fennel = {workspace = {library = vim.api.nvim_list_runtime_paths()}, diagnostics = {globals = {"vim", "comment"}}}}, filetypes = {"fennel"}, single_file_support = true, root_dir = lsp_util.root_pattern("fnl"), on_attach = _13_}))
  return lsp.clojure_lsp.setup(default_map)
end
return {tx("neovim/nvim-lspconfig", {dependencies = {"williamboman/mason.nvim", "RRethy/vim-illuminate", "nvim-lua/plenary.nvim"}, event = {"BufReadPre", "BufNewFile"}, init = _5_, config = _6_})}
