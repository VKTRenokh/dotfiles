local keymap = require("config.functions").keymap

-- {{{ General mappings

-- Modes
-- normal_mode =       "n",
-- insert_mode =       "i",
-- visual_mode =       "v",
-- visual_block_mode = "x",
-- term_mode =         "t",
-- command_mode =      "c",

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

-- Resize splits
keymap("n", "<M-,>", "<c-w>5>")
keymap("n", "<M-.>", "<c-w>5<")
keymap("n", "<M-t>", "<C-W>+")
keymap("n", "<M-s>", "<C-W>-")

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>")
keymap("n", "<S-h>", ":bprevious<CR>")

-- Inc and Dec numbers
keymap("n", "+", "<C-a>")
keymap("n", "-", "<C-x>")

-- Splits
keymap("n", "<leader>s", ":split<cr><C-w>w")
keymap("n", "sv", ":vsplit<cr><C-w>w")
keymap("n", "<leader>", "<C-w>w")

-- Select (charwise) the contents of the current line, excluding indentation.
keymap("n", "vv", "^vg_")

-- Save all files.
keymap("n", "<F2>", "<cmd>wall<cr>")

-- Toggle [in]visible characters.
keymap("n", "<leader>i", "<cmd>set list!<cr>")

-- Stay in indent mode.
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Visual yank
keymap("v", "<leader>cc", '"+y')

-- Obfuscate
keymap("n", "<F3>", "mmggg?G`m")

-- Delete
keymap("n", "<leader>d", '"_d')
keymap("n", "x", '"_x')
keymap("n", "dw", 'vb"_d')

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==")
keymap("v", "<A-k>", ":m .-2<CR>==")
keymap("v", "p", '"_dP')
keymap("x", "J", ":m '>+1<CR>gv-gv")
keymap("x", "K", ":m '<-2<CR>gv-gv")
keymap("x", "<A-j>", ":m '>+1<CR>gv-gv")
keymap("x", "<A-k>", ":m '<-2<CR>gv-gv")

-- Alternative ESC key to avoid <Ctrl-[>.  Useful when a RCP is used to connect
-- to a remote host.
keymap("i", "jk", "<esc>")
keymap("c", "jk", "<esc>")
-- ------------------------------------------------------------------------- }}}
-- {{{ Folding commands.

-- Close all fold except the current one.
keymap("n", "zv", "zMzvzz")

-- Close current fold when open. Always open next fold.
keymap("n", "zj", "zcjzOzz")

-- Close current fold when open. Always open previous fold.
keymap("n", "zk", "zckzOzz")

-- ------------------------------------------------------------------------- }}}
-- {{{ Keep the cursor in place while joining lines.

keymap("n", "J", "mzJ`z")
keymap("n", "<leader>J", "myvipJ`ygq<cr>")

-- ------------------------------------------------------------------------- }}}
---- {{{ Shell commands.

-- Execute the current line of test as a shell command.
keymap("n", "<localleader>E", [[0mMvg_"ky :exec "r!" getreg("k")<cr>]])
keymap("v", "<localleader>E", [["ky :exec "r!" getreg("k")<cr>]])

-- ------------------------------------------------------------------------- }}}
-- {{{ Quit all

keymap("n", "<c-q>", "<cmd>qall!<cr>")
keymap("n", "<leader>qq", "<cmd>qall!<cr>")

-- ------------------------------------------------------------------------- }}}
---- {{{ leader + space

keymap("n", "<leader><space>", "<cmd>nohlsearch<cr>")

-- ------------------------------------------------------------------------- }}}
-- {{{ Lazy
keymap("n", "<leader>l", "<cmd>:Lazy<cr>")
-- }}}
-- {{{ Keep cursor in the center of the screen when scrolling with C-e or C-y
keymap("n", "<leader>to", function()
  vim.opt.scrolloff = 999 - vim.o.scrolloff
end)
-- }}}
-- {{{ Vim mappings in russian
-- stylua: ignore
local langmap_keys = {
  'ёЁ;`~', '№;#',
  'йЙ;qQ', 'цЦ;wW', 'уУ;eE', 'кК;rR', 'еЕ;tT', 'нН;yY', 'гГ;uU', 'шШ;iI', 'щЩ;oO', 'зЗ;pP', 'хХ;[{', 'ъЪ;]}',
  'фФ;aA', 'ыЫ;sS', 'вВ;dD', 'аА;fF', 'пП;gG', 'рР;hH', 'оО;jJ', 'лЛ;kK', 'дД;lL', [[жЖ;\;:]], [[эЭ;'\"]],
  'яЯ;zZ', 'чЧ;xX', 'сС;cC', 'мМ;vV', 'иИ;bB', 'тТ;nN', 'ьЬ;mM', [[бБ;\,<]], 'юЮ;.>',
}
vim.o.langmap = table.concat(langmap_keys, ",")
-- }}}
-- {{{ Reload file and lsp
keymap("n", "<leader>L", function()
  vim.cmd("e")
  vim.cmd("LspRestart")
  require("config.functions").notify("Reloaded file and lsp")
end)
-- }}}
