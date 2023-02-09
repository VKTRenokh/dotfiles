local options = {
  autoindent = true,
  backup = false,
  backspace = { "start", "eol", "indent" },
  cmdheight = 1,
  completeopt = { "menuone", "noselect" },
  conceallevel = 0,
  fileencoding = "utf-8",
  hlsearch = true,
  ignorecase = true,
  mouse = "a",
  pumheight = 10,
  showmode = false,
  showtabline = 2,
  smartcase = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  termguicolors = true,
  timeoutlen = 100,
  undofile = true,
  updatetime = 300,
  writebackup = false,
  expandtab = true,
  shiftwidth = 2,
  tabstop = 2,
  cursorline = true,
  number = true,
  relativenumber = true,
  numberwidth = 4,
  --[[ signcolumn = "yes", ]]
  wrap = false,
  scrolloff = 10,
  sidescrolloff = 10,
  shell = "fish",
  exrc = true,
  title = true,
  winblend = 0,
  wildoptions = "pum",
  pumblend = 5,
  background = 'dark'
}

vim.scriptencoding = 'utf-8'
vim.opt.shortmess:append "c"
vim.opt.path:append { '**' }
vim.opt.formatoptions:append { 'r' }

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd [[language en_US.UTF-8]]
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]]
vim.cmd [[set clipboard+=unnamedplus]]
vim.cmd [[set wildignore+=*/node_modules/*]]
vim.cmd [[autocmd InsertLeave * set nopaste]]
vim.cmd [[
augroup BgHighlight
  autocmd!
  autocmd WinEnter * set cul
  autocmd WinLeave * set nocul
augroup END
]]
vim.cmd [[
if &term =~ "screen"
  autocmd BufEnter * if bufname("") !~ "^?[A-Za-z0-9?]*://" | silent! exe '!echo -n "\ek[`hostname`:`basename $PWD`/`basename %`]\e\\"' | endif
  autocmd VimLeave * silent!  exe '!echo -n "\ek[`hostname`:`basename $PWD`]\e\\"'
endif
]]
vim.cmd [[autocmd FileType * set formatoptions-=ro]]
