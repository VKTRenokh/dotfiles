local M = {}

---@param mode string
---@param lhs string
---@param rhs string|function
---@param opts table|nil
function M.keymap(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  options = vim.tbl_deep_extend("force", options, opts or {})
  vim.keymap.set(mode, lhs, rhs, options)
end

local default_notify_options = {
  title = "Configuration",
}

local function rewrite_notify_options(options)
  if not options then
    return default_notify_options
  end
  options.title = options.title or default_notify_options.title
  return options
end

---@param text string
---@param level string | nil
---@param options table<string, string> | nil
---@return nil
function M.notify(text, level, options)
  level = level or vim.log.levels.INFO

  vim.notify(text, level, rewrite_notify_options(options))
end

---@param table table
---@param fn function
function M.each(table, fn)
  for k, v in pairs(table) do
    fn(v, k)
  end
end

---@param table table
function M.set(table, value)
  return function(key)
    table[key] = value
  end
end

function M.config_files()
  require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
end

return M
