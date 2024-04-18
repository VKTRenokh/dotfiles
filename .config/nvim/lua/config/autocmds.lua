Keymap = vim.keymap
-- ------------------------------------------------------------------------- }}}

-- {{{ Close some filetypes with <q>.
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"notify",
		"qf",
		"query",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"neotest-output",
		"checkhealth",
		"neotest-summary",
		"neotest-output-panel",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})
-- {{{ Hightlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})
-- ------------------------------------------------------------------------- }}}
-- {{{ Reload file when necessay.

vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, { command = "checktime" })

-- ------------------------------------------------------------------------- }}}
-- {{{ Resize splits when window is resized.

vim.api.nvim_create_autocmd({ "VimResized" }, {
	callback = function()
		local currentTab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd")
		vim.cmd("tabnext " .. currentTab)
	end,
})

-- ------------------------------------------------------------------------- }}}
