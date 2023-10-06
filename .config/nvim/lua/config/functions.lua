local Util = require("lazy.core.util")
Customize = require("config.customize")
local M = {}

function M.on_attach(on_attach)
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local buffer = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			on_attach(client, buffer)
		end,
	})
end

function M.has(plugin)
	return require("lazy.core.config").plugins[plugin] ~= nil
end

---@param fn fun()
function M.on_very_lazy(fn)
	vim.api.nvim_create_autocmd("User", {
		pattern = "VeryLazy",
		callback = function()
			fn()
		end,
	})
end

function M.opts(name)
	local plugin = require("lazy.core.config").plugins[name]
	if not plugin then
		return {}
	end
	local Plugin = require("lazy.core.plugin")
	return Plugin.values(plugin, "opts", false)
end

function M.keymap(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	options = vim.tbl_deep_extend("force", options, opts or {})
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function M.is_enabled(plugin)
	return Customize.plugins[plugin].enabled
end

return M
