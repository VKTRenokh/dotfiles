-- {{{ Global definitions

Customize = require("config.customize")
Functions = require("config.functions")
Keymap = Functions.keymap
Is_Enabled = Functions.is_enabled

-- ------------------------------------------------------------------------- }}}
-- {{{ General mappings

-- Modes
-- normal_mode =       "n",
-- insert_mode =       "i",
-- visual_mode =       "v",
-- visual_block_mode = "x",
-- term_mode =         "t",
-- command_mode =      "c",

-- Better window navigation
Keymap("n", "<C-h>", "<C-w>h")
Keymap("n", "<C-j>", "<C-w>j")
Keymap("n", "<C-k>", "<C-w>k")
Keymap("n", "<C-l>", "<C-w>l")
Keymap("n", "sh", "<C-w>h")
Keymap("n", "sj", "<C-w>j")
Keymap("n", "sk", "<C-w>k")
Keymap("n", "sl", "<C-w>l")
Keymap("n", "s<left>", "<C-w>h")
Keymap("n", "s<right>", "<C-w>l")
Keymap("n", "s<down>", "<C-w>j")
Keymap("n", "s<up>", "<C-w>k")

-- Resize with arrows
Keymap("n", "<C-Up>", ":resize -2<CR>")
Keymap("n", "<C-Down>", ":resize +2<CR>")
Keymap("n", "<C-Left>", ":vertical resize -2<CR>")
Keymap("n", "<C-Right>", ":vertical resize +2<CR>")

-- Navigate buffers
Keymap("n", "<S-l>", ":bnext<CR>")
Keymap("n", "<S-h>", ":bprevious<CR>")

-- Inc and Dec numbers
Keymap("n", "+", "<C-a>")
Keymap("n", "-", "<C-x>")

-- Tabs
Keymap("n", "te", ":tabedit<cr>")
Keymap("n", "<S-Tab>", ":tabprev<cr>")
Keymap("n", "<Tab>", ":tabnext<cr>")

-- Splits
Keymap("n", "<leader>s", ":split<cr><C-w>w")
Keymap("n", "sv", ":vsplit<cr><C-w>w")
Keymap("n", "<leader>", "<C-w>w")

-- Select (charwise) the contents of the current line, excluding indentation.
Keymap("n", "vv", "^vg_")

-- Select entire buffer
Keymap("n", "<C-a>", "ggVG")
Keymap("n", "<leader>V", "V`]")

-- Save all files.
Keymap("n", "<F2>", "<cmd>wall<cr>")

-- Delete current buffer.
if Is_Enabled("vim-bbye") then
	Keymap("n", "Q", "<cmd>Bdelete!<cr>")
end

-- Toggle [in]visible characters.
Keymap("n", "<leader>i", "<cmd>set list!<cr>")

-- Stay in indent mode.
Keymap("v", "<", "<gv")
Keymap("v", ">", ">gv")

-- Visual yank
Keymap("v", "<leader>cc", '"+y')

-- Obfuscate
Keymap("n", "<F3>", "mmggg?G`m")

-- Delete
Keymap("n", "<leader>d", '"_d')
Keymap("n", "x", '"_x')
Keymap("n", "dw", 'vb"_d')

-- Move text up and down
Keymap("v", "<A-j>", ":m .+1<CR>==")
Keymap("v", "<A-k>", ":m .-2<CR>==")
Keymap("v", "p", '"_dP')
Keymap("x", "J", ":m '>+1<CR>gv-gv")
Keymap("x", "K", ":m '<-2<CR>gv-gv")
Keymap("x", "<A-j>", ":m '>+1<CR>gv-gv")
Keymap("x", "<A-k>", ":m '<-2<CR>gv-gv")

-- Alternative ESC key to avoid <Ctrl-[>.  Useful when a RCP is used to connect
-- to a remote host.
Keymap("i", "jk", "<esc>")
Keymap("c", "jk", "<esc>")
-- ------------------------------------------------------------------------- }}}
-- {{{ Folding commands.

-- Close all fold except the current one.
Keymap("n", "zv", "zMzvzz")

-- Close current fold when open. Always open next fold.
Keymap("n", "zj", "zcjzOzz")

-- Close current fold when open. Always open previous fold.
Keymap("n", "zk", "zckzOzz")

-- ------------------------------------------------------------------------- }}}
-- {{{ Keep the cursor in place while joining lines.

Keymap("n", "J", "mzJ`z")
Keymap("n", "<leader>J", "myvipJ`ygq<cr>")

-- ------------------------------------------------------------------------- }}}
---- {{{ Shell commands.

-- Execute the current line of test as a shell command.
Keymap("n", "<localleader>E", [[0mMvg_"ky :exec "r!" getreg("k")<cr>]])
Keymap("v", "<localleader>E", [["ky :exec "r!" getreg("k")<cr>]])

-- ------------------------------------------------------------------------- }}}
-- {{{ Quit all

Keymap("n", "<c-q>", "<cmd>qall!<cr>")
Keymap("n", "<leader>qq", "<cmd>qall!<cr>")

-- ------------------------------------------------------------------------- }}}
---- {{{ leader + space

Keymap("n", "<leader><space>", "<cmd>nohlsearch<cr>")

-- ------------------------------------------------------------------------- }}}
-- {{{ Help

Keymap("n", "<leader>HH", "<cmd>silent vert bo help<cr>")

-- ------------------------------------------------------------------------- }}}
-- {{{ A - Alpha

if Is_Enabled("alpha.nvim") then
	Keymap("n", "<leader>aa", "<cmd>Alpha<cr>")
end

-- ------------------------------------------------------------------------- }}}
-- {{{ B - BufferLine

if Is_Enabled("bufferline.nvim") then
	Keymap("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>")
	Keymap("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>")
end

-- ------------------------------------------------------------------------- }}}
-- {{{ S - Gitsigns

if Is_Enabled("gitsigns.nvim") then
	Keymap("n", "<leader>SR", '<cmd>lua require "gitsigns".reset_hunk()<cr>')
	Keymap("n", "<leader>SS", '<cmd>lua require "gitsigns".stage_hunk()<cr>')
	Keymap("n", "<leader>Sd", "<cmd>Gitsigns diffthis HEAD<cr>")
	Keymap("n", "<leader>Sh", '<cmd>lua require "gitsigns".undo_stage_hunk()<cr>')
	Keymap("n", "<leader>Sj", '<cmd>lua require "gitsigns".next_hunk()<cr>')
	Keymap("n", "<leader>Sk", '<cmd>lua require "gitsigns".prev_hunk()<cr>')
	Keymap("n", "<leader>Sp", '<cmd>lua require "gitsigns".preview_hunk()<cr>')
	Keymap("n", "<leader>Sr", '<cmd>lua require "gitsigns".reset_buffer()<cr>')
end

-- ------------------------------------------------------------------------- }}}
-- {{{ L - LSP

-- TODO: Finish implementing LSP keybindings.  Some plugins are not installed.

-- LSP
if Is_Enabled("lsp-config") then
	Keymap("n", "<leader>LF", "<cmd>LspToggleAutoFormat<cr>")
	Keymap("n", "<leader>Li", "<cmd>LspInfo<cr>")

	-- vim.lsp
	Keymap("n", "<leader>Ll", "<cmd>lua vim.lsp.codelens.run()<cr>")
	Keymap("n", "<leader>Lq", "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>")

	-- vim.lsp.buf
	Keymap("n", "<leader>La", "<cmd>lua vim.lsp.buf.code_action()<cr>")
	Keymap("n", "<leader>Lf", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>")
	Keymap("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<cr>")
end

-- SymoblsOutline
if Is_Enabled("symbols-outline") then
	Keymap("n", "<leader>o", "<cmd>SymbolsOutline<cr>")
end

--Telescope
if Is_Enabled("telescope.nvim") then
	Keymap("n", "<leader>LS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>")
	Keymap("n", "<leader>Ls", "<cmd>Telescope lsp_document_symbols<cr>")
end

-- Trouble
if Is_Enabled("trouble.nvim") then
	Keymap("n", "<leader>LR", "<cmd>TroubleToggle lsp_references<cr>")
	Keymap("n", "<leader>Ld", "<cmd>TroubleToggle<cr>")
end

-- vim.diagnostic
Keymap("n", "<leader>Lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>")
Keymap("n", "<leader>Lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>")

-- ------------------------------------------------------------------------- }}}
-- {{{ T - Telescope

if Is_Enabled("telescope.nvim") then
	vim.keymap.set("n", ";f", function()
		require("telescope.builtin").find_files({ hidden = true })
	end)
	vim.keymap.set("n", ";r", function()
		require("telescope.builtin").live_grep()
	end)
	vim.keymap.set("n", "\\\\", function()
		require("telescope.builtin").buffers()
	end)
	vim.keymap.set("n", ";t", function()
		require("telescope.builtin").help_tags()
	end)
	vim.keymap.set("n", ";;", function()
		require("telescope.builtin").resume()
	end)
	vim.keymap.set("n", ";e", function()
		require("telescope.builtin").diagnostics()
	end)
	vim.keymap.set("n", "sf", function()
		require("telescope").extensions.file_browser.file_browser({
			path = "%:p:h",
			cwd = vim.fn.expand("%:p:h"),
			respect_gitignore = false,
			hidden = true,
			grouped = true,
			previewer = false,
			initial_mode = "normal",
			layout_config = { prompt_position = "top", height = 60 },
			layout_strategy = "horizontal",
		})
	end)
end

-- ------------------------------------------------------------------------- }}}
-- {{{ T - ToggleTerm

Keymap("n", "<leader>Tg", "<cmd>lua Customize.toggleterm.lazygit()<cr>")

-- ------------------------------------------------------------------------- }}}
-- {{{ V - Linewise reselection of what you just pasted.

Keymap("n", "<leader>VV", "V`]")

-- ------------------------------------------------------------------------- }}}
