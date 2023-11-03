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

-- Resize with arrows
Keymap("n", "<C-S-Up>", "<Cmd>:resize -2<CR>")
Keymap("n", "<C-S-Down>", "<Cmd>:resize +2<CR>")

Keymap("n", "<C-S-Left>", "<Cmd>:vertical resize -2<CR>")
Keymap("n", "<C-S-Right>", "<Cmd>:vertical resize +2<CR>")

-- Navigate buffers
Keymap("n", "<S-l>", ":bnext<CR>")
Keymap("n", "<S-h>", ":bprevious<CR>")

-- Inc and Dec numbars
Keymap("n", "+", "<C-a>")
Keymap("n", "-", "<C-x>")

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
-- {{{ L - LSP

-- TODO: Finish implementing LSP keybindings.  Some plugins are not installed.

Keymap("n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>")
Keymap("n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>")
Keymap("n", "K", ":lua vim.lsp.buf.hover()<CR>")

-- ------------------------------------------------------------------------- }}}
-- {{{ V - Linewise reselection of what you just pasted.

Keymap("n", "<leader>VV", "V`]")

-- ------------------------------------------------------------------------- }}}
vim.keymap.set("n", "gp", function()
	return "`[" .. vim.fn.strpart(vim.fn.getregtype(), 0, 1) .. "`]"
end, { expr = true })
