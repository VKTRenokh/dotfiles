Customize = require("config.customize")
Keymap = vim.keymap

-- {{{ Clear items that make transparency look bad.

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		vim.cmd([[ highlight clear Folded ]])

		if Customize.virtcolumn_nvim then
			vim.cmd([[ highlight ColorColumn guibg=#292d42 ]])
		else
			vim.cmd([[ highlight ColorColumn guibg=#202031 ]])
		end

		vim.cmd([[ highlight LineNr guifg=#e0af68 ]])
		vim.cmd([[ highlight LineNrAbove guifg=#787c99 ]])
		vim.cmd([[ highlight LineNrBelow guifg=#787c99 ]])
	end,
})

-- ------------------------------------------------------------------------- }}}
-- {{{ Close some filetypes with <q>.

vim.api.nvim_create_autocmd("Filetype", {
	pattern = {
		"alpha",
		"PlenaryTestPopup",
		"dashboard",
		"fugitive",
		"help",
		"lspinfo",
		"man",
		"mason",
		"notify",
		"qf",
		"spectre_panel",
		"startuptime",
		"tsplayground",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		Keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})
-- ------------------------------------------------------------------------- }}}
-- {{{ Format options

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		vim.cmd([[ setlocal formatoptions+=c ]])
		vim.cmd([[ setlocal formatoptions+=j ]])
		vim.cmd([[ setlocal formatoptions+=n ]])
		vim.cmd([[ setlocal formatoptions+=q ]])
		vim.cmd([[ setlocal formatoptions+=r ]])
		vim.cmd([[ setlocal formatoptions-=2 ]])
		vim.cmd([[ setlocal formatoptions-=a ]])
		vim.cmd([[ setlocal formatoptions-=o ]])
		vim.cmd([[ setlocal formatoptions-=t ]])
	end,
})
-- ------------------------------------------------------------------------- }}}
-- {{{ Goto last location when opening a buffer.
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})
-- ------------------------------------------------------------------------- }}}
-- {{{ Hightlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({
			higroup = "YankHighlight",
		})
	end,
	group = highlight_group,
	pattern = "*",
})
-- ------------------------------------------------------------------------- }}}
-- {{{ json
local json_group = vim.api.nvim_create_augroup("Json", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	command = [[syntax match Comment +\/\/.\+$+]],
	group = json_group,
	pattern = "*.json",
})
-- ------------------------------------------------------------------------- }}}
-- {{{ Reload file when necessay.

vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, { command = "checktime" })

-- ------------------------------------------------------------------------- }}}
-- {{{ Resize splits when window is resized.

vim.api.nvim_create_autocmd({ "VimResized" }, {
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- ------------------------------------------------------------------------- }}}
-- {{{ Set spelling for some file types.

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "gitcommit", "markdown", "wiki" },
	callback = function()
		vim.opt_local.spell = true
	end,
})

-- ------------------------------------------------------------------------- }}}
-- {{{ WhiteSpace

local whitespace_group = vim.api.nvim_create_augroup("WhiteSpace", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
	command = [[%s/\s\+$//e]],
	group = whitespace_group,
})

-- ------------------------------------------------------------------------- }}}
