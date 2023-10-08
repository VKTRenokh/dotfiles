local M = {}

M._keys = nil

function M.get()
	local format = require("plugins.lsp.format").format
	if not M._keys then
		M._keys = {
			{ "<leader>cd", vim.diagnostic.open_float, desc = "Line Diagnostics" },
			{ "]d", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
			{ "<c-j>", M.diagnostic_goto(true), desc = "Next Diagnostic" },
			{ "<c-k>", M.diagnostic_goto(false), desc = "Prev Diagnostic" },
			{ "]e", M.diagnostic_goto(true, "ERROR"), desc = "Next Error" },
			{ "[e", M.diagnostic_goto(false, "ERROR"), desc = "Prev Error" },
			{ "]w", M.diagnostic_goto(true, "WARN"), desc = "Next Warning" },
			{ "[w", M.diagnostic_goto(false, "WARN"), desc = "Prev Warning" },
			{ "<leader>cf", format, desc = "Format Document", has = "documentFormatting" },
			{ "<leader>cf", format, desc = "Format Range", mode = "v", has = "documentRangeFormatting" },
			{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
			{
				"<leader>cA",
				function()
					vim.lsp.buf.code_action({
						context = {
							only = {
								"source",
							},
							diagnostics = {},
						},
					})
				end,
				desc = "Source Action",
				has = "codeAction",
			},
		}
		if require("config.functions").has("inc-rename.nvim") then
			M._keys[#M._keys + 1] = {
				"<leader>cr",
				function()
					require("inc_rename")
					return ":IncRename " .. vim.fn.expand("<cword>")
				end,
				expr = true,
				desc = "Rename",
				has = "rename",
			}
		else
			M._keys[#M._keys + 1] = { "<leader>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" }
		end
	end
	return M._keys
end

function M.on_attach(client, buffer)
	local Keys = require("lazy.core.handler.keys")
	local keymaps = {}

	for _, value in ipairs(M.get()) do
		local keys = Keys.parse(value)
		if keys[2] == vim.NIL or keys[2] == false then
			keymaps[keys.id] = nil
		else
			keymaps[keys.id] = keys
		end
	end

	for _, keys in pairs(keymaps) do
		if not keys.has or client.server_capabilities[keys.has .. "Provider"] then
			local opts = Keys.opts(keys)
			opts.has = nil
			opts.silent = true
			opts.buffer = buffer
			vim.keymap.set(keys.mode or "n", keys[1], keys[2], opts)
		end
	end
end

function M.diagnostic_goto(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end

return M
