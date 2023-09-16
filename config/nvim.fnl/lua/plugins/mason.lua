-- [nfnl] Compiled from fnl/plugins/mason.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local uu = autoload("config.util")
local _local_2_ = (autoload("config.constants")).ensure_installed
local mason = _local_2_["mason"]
local _local_3_ = autoload("config.constants")
local lua_ls = _local_3_["lua_ls"]
local _local_4_ = autoload("config.constants")
local icons = _local_4_["icons"]
local function _5_(_, opts)
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
local function _7_()
  return (autoload("config.util")).has("nvim-cmp")
end
local function _8_(_, opts)
  local on_attach = (require("plugins.lsp.format")).on_attach
  local icons0 = (require("config.constants")).icons
  require("plugins.lsp.format")["autoformat"] = opts.autoformat
  local function _9_(client, buffer)
    do end (require("plugins.lsp.format")).on_attach(client, buffer)
    do end (require("plugins.lsp.keymaps")).on_attach(client, buffer)
    return nil
  end
  do end (require("config.util"))["on-attach"](_9_)
  local register_capability = vim.lsp.handlers["client/registerCapability"]
  local function _10_(err, res, ctx)
    local ret = register_capability(err, res, ctx)
    local client_id = ctx.client_id
    local client = vim.lsp.get_client_by_id(client_id)
    local buffer = vim.api.nvim_get_current_buf()
    do end (require("plugins.lsp.keymaps")).on_attach(client, buffer)
    return ret
  end
  vim.lsp.handlers["client/registerCapability"] = _10_
  for name, icon in pairs(icons0.diagnostics) do
    name = ("DiagnosticSign" .. name)
    vim.fn.sign_define(name, {numhl = "", text = icon, texthl = name})
  end
  local inlay_hint = (vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint)
  if (opts.inlay_hints.enabled and inlay_hint) then
    local function _11_(client, buffer)
      if client.supports_method("textDocument/inlayHint") then
        return inlay_hint(buffer, true)
      else
        return nil
      end
    end
    on_attach(_11_)
  else
  end
  if ((type(opts.diagnostics.virtual_text) == "table") and (opts.diagnostics.virtual_text.prefix == "icons")) then
    local function _14_(diagnostic)
      for d, icon in pairs(icons0) do
        if (diagnostic.severity == vim.diagnostic.severity[d:upper()]) then
          return icon
        else
        end
      end
      return nil
    end
    opts.diagnostics.virtual_text.prefix = (((vim.fn.has("nvim-0.10.0") == 0) and "\226\151\143") or _14_)
  else
  end
  vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
  local servers = opts.servers
  local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  local capabilities = vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), ((has_cmp and cmp_nvim_lsp.default_capabilities()) or {}), (opts.capabilities or {}))
  local function setup(server)
    local server_opts = vim.tbl_deep_extend("force", {capabilities = vim.deepcopy(capabilities)}, (servers[server] or {}))
    if opts.setup[server] then
      if opts.setup[server](server, server_opts) then
        return 
      else
      end
    elseif opts.setup["*"] then
      if opts.setup["*"](server, server_opts) then
        return 
      else
      end
    else
    end
    return ((require("lspconfig"))[server]).setup(server_opts)
  end
  local have_mason, mlsp = pcall(require, "mason-lspconfig")
  local all_mslp_servers = {}
  if have_mason then
    all_mslp_servers = vim.tbl_keys((require("mason-lspconfig.mappings.server")).lspconfig_to_package)
  else
  end
  local ensure_installed = {}
  for server, server_opts in pairs(servers) do
    if server_opts then
      server_opts = (((server_opts == true) and {}) or server_opts)
      if ((server_opts.mason == false) or not vim.tbl_contains(all_mslp_servers, server)) then
        setup(server)
      else
        ensure_installed[(#ensure_installed + 1)] = server
      end
    else
    end
  end
  if have_mason then
    return mlsp.setup({ensure_installed = ensure_installed, handlers = {setup}})
  else
    return nil
  end
end
local function _24_()
  local nls = require("null-ls")
  return {root_dir = (require("null-ls.utils")).root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"), sources = {nls.builtins.formatting.stylua, nls.builtins.formatting.prettierd}}
end
return {uu.tx("williamboman/mason.nvim", {opts = {ui = {border = "rounded", icons = {package_installed = "\226\151\141", package_pending = "\226\151\141", package_uninstalled = "\226\151\141"}}, log_level = vim.log.levels.INFO, max_concurrent_installers = 5, ensure_installed = mason}, cmd = "Mason", config = _5_}), uu.tx("neovim/nvim-lspconfig", {event = {"BufReadPre", "BufNewFile"}, dependencies = {{"folke/neoconf.nvim", cmd = "Neoconf", config = true, enabled = false}, {"folke/neodev.nvim", opts = {experimental = {pathStrict = true}}, enabled = false}, "mason.nvim", "williamboman/mason-lspconfig.nvim", {"RRethy/vim-illuminate", enabled = false}, {"hrsh7th/cmp-nvim-lsp", cond = _7_}, "SmiteshP/nvim-navic"}, opts = {diagnostics = {underline = true, virtual_text = {spacing = 4, prefix = "\226\151\143"}, severity_sort = true, update_in_insert = false}, autoformat = true, inlay_hints = {enable = false}, format = {formatting_options = nil, timeout_ms = nil}, servers = {lua_ls = {settings = {Lua = lua_ls.Lua}}}, setup = {}}, config = _8_}), uu.tx("jose-elias-alvarez/null-ls.nvim", {event = {"BufReadPre", "BufNewFile"}, dependencies = "williamboman/mason.nvim", opts = _24_}), uu.tx("simrat39/symbols-outline.nvim", {keys = {{"<leader>o", "<cmd>SymbolsOutline<cr>"}}, cmd = "SymbolsOutline", opts = {highlight_hovered_item = true, show_guides = true, position = "right", relative_width = true, width = 45, show_symbol_details = true, preview_bg_highlight = "Pmenu", autofold_depth = nil, auto_unfold_hover = true, fold_markers = {["\239\145\160"] = "\239\145\188"}, keymaps = {close = {["<Esc>"] = "q"}, goto_location = "<Cr>", focus_location = "o", hover_symbol = "<C-space>", toggle_preview = "K", rename_symbol = "r", code_actions = "a", fold = "h", unfold = "l", fold_all = "W", unfold_all = "E", fold_reset = "R"}, lsp_blacklist = {}, symbol_blacklist = {}, symbols = {File = {icon = icons.kind.File, hl = "@text.uri"}, Module = {icon = icons.kind.Module, hl = "@namespace"}, Namespace = {icon = icons.type.Array, hl = "@namespace"}, Package = {icon = icons.misc.Package, hl = "@namespace"}, Class = {icon = icons.kind.Class, hl = "@type"}, Method = {icon = icons.kind.Method, hl = "@method"}, Property = {icon = icons.kind.Property, hl = "@method"}, Field = {icon = icons.kind.Field, hl = "@field"}, Constructor = {icon = icons.kind.Constructor, hl = "@constructor"}, Enum = {icon = icons.kind.Enum, hl = "@type"}, Interface = {icon = icons.kind.Interface, hl = "@type"}, Function = {icon = icons.kind.Function, hl = "@function"}, Variable = {icon = icons.kind.Variable, hl = "@constant"}, Constant = {icon = icons.kind.Constant, hl = "@constant"}, String = {icon = icons.kind.Struct, hl = "@string"}, Number = {icon = icons.kind.Number, hl = "@number"}, Boolean = {icon = icons.kind.Boolean, hl = "@boolean"}, Array = {icon = icons.type.Array, hl = "@constant"}, Object = {icon = icons.type.Object, hl = "@type"}, Key = {icon = "\240\159\148\144", hl = "@type"}, Null = {icon = "NULL", hl = "@type"}, EnumMember = {icon = icons.kind.EnumMember, hl = "@field"}, Struct = {icon = icons.kind.Struct, hl = "@type"}, Event = {icon = icons.kind.Event, hl = "@type"}, Operator = {icon = icons.kind.Operator, hl = "@operator"}, TypeParameter = {icon = icons.kind.TypeParameter, hl = "@parameter"}, Component = {icon = icons.type.Array, hl = "@function"}, Fragment = {icon = icons.type.Array, hl = "@constant"}}, wrap = false, show_numbers = false, show_relative_numbers = false, auto_close = false, auto_preview = false}})}
