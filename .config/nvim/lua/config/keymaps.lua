local map = require("config.functions").keymap

-- {{{ General mappings

-- Modes
-- normal_mode =       "n",
-- insert_mode =       "i",
-- visual_mode =       "v",
-- visual_block_mode = "x",
-- term_mode =         "t",
-- command_mode =      "c",

-- Better window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Resize splits
map("n", "<M-,>", "<c-w>5>")
map("n", "<M-.>", "<c-w>5<")
map("n", "<M-t>", "<C-W>+")
map("n", "<M-s>", "<C-W>-")

-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>")
map("n", "<S-h>", ":bprevious<CR>")

-- Inc and Dec numbers
map("n", "+", "<C-a>")
map("n", "-", "<C-x>")

-- Splits
map("n", "<leader>s", ":split<cr><C-w>w")
map("n", "sv", ":vsplit<cr><C-w>w")
map("n", "<leader>", "<C-w>w")

-- Select (charwise) the contents of the current line, excluding indentation.
map("n", "vv", "^vg_")

-- Save all files.
map("n", "<F2>", "<cmd>wall<cr>")

-- Toggle [in]visible characters.
map("n", "<leader>i", "<cmd>set list!<cr>")

-- Stay in indent mode.
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Visual yank
map("v", "<leader>cc", '"+y')

-- Obfuscate
map("n", "<F3>", "mmggg?G`m")

-- Delete
map("n", "<leader>d", '"_d')
map("n", "x", '"_x')
map("n", "dw", 'vb"_d')

-- Move text up and down
map("v", "<A-j>", ":m .+1<CR>==")
map("v", "<A-k>", ":m .-2<CR>==")
map("v", "p", '"_dP')
map("x", "J", ":m '>+1<CR>gv-gv")
map("x", "K", ":m '<-2<CR>gv-gv")
map("x", "<A-j>", ":m '>+1<CR>gv-gv")
map("x", "<A-k>", ":m '<-2<CR>gv-gv")

-- ------------------------------------------------------------------------- }}}
-- {{{ Folding commands.

-- Close all fold except the current one.
map("n", "zv", "zMzvzz")

-- Close current fold when open. Always open next fold.
map("n", "zj", "zcjzOzz")

-- Close current fold when open. Always open previous fold.
map("n", "zk", "zckzOzz")

-- ------------------------------------------------------------------------- }}}
-- {{{ Keep the cursor in place while joining lines.

map("n", "J", "mzJ`z")
map("n", "<leader>J", "myvipJ`ygq<cr>")

-- ------------------------------------------------------------------------- }}}
---- {{{ Shell commands.

-- Execute the current line of test as a shell command.
map("n", "<localleader>E", [[0mMvg_"ky :exec "r!" getreg("k")<cr>]])
map("v", "<localleader>E", [["ky :exec "r!" getreg("k")<cr>]])

-- ------------------------------------------------------------------------- }}}
-- {{{ Keep cursor in the center of the screen when scrolling with C-e or C-y
map("n", "<leader>to", function()
  vim.opt.scrolloff = 999 - vim.o.scrolloff
end)
-- }}}
-- {{{ commenting
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })
-- }}}
-- change current line without yanking it{{{
map("n", "<leader>c", '"_cc') -- }}}
-- {{{ <C-i> fix
-- When mapping <Tab> this keymap looses it's functionality so you have to
-- remap it to itself
map("n", "<C-i>", "<C-i>") -- }}}
map("n", "<leader>dt", "<Cmd>:pu=strftime('%c')<cr>")

map("n", "<leader>in", "<Cmd>:set fo-=tc<cr>")

map("n", "ycc", function()
  return "yy" .. vim.v.count1 .. "gcc']p"
end, { remap = true, expr = true })

vim.keymap.set("i", "<C-L>", function()
  local node = vim.treesitter.get_node()
  if node ~= nil then
    local row, col = node:end_()
    pcall(vim.api.nvim_win_set_cursor, 0, { row + 1, col })
  end
end, { desc = "insjump" })
