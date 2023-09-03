-- [nfnl] Compiled from lspzero.fnl by https://github.com/Olical/nfnl, do not edit.
local uu = require("vktrenokh.util")
local function _1_()
  local lsp = (require("lsp-zero")).preset({})
  local function _2_(client, bufnr)
    return lsp.default_keyamps({buffer = bufnr})
  end
  return lsp.on_attach(_2_)
end
return uu.tx("VonHeikemen/lsp-zero.nvim", {config = _1_})
