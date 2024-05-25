local M = {}

function M.keymap(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  options = vim.tbl_deep_extend("force", options, opts or {})
  vim.keymap.set(mode, lhs, rhs, options)
end

return M
