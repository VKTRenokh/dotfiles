(local util (require :vktrenokh.util))

(local options {
:autoindent true
:background "dark"
:backup false
:backspace ["start" "eol" "indent"]
:breakindent true
:cmdheight 1
:clipboard "unnamedplus"
:colorcolumn "+1"
:complete ["." "w" "u" "b" "t" "i" "kspell"]
:completeopt [ "menuone" "noinsert" "noselect" ]
:conceallevel 0
:cursorline true
:expandtab true
:exrc true
:fileencoding "utf-8"
:fillchars {:fold " " :eob " "}
:foldlevel 0
:foldmethod  :marker
:hlsearch  false
:hidden  true
:ignorecase  true
:list  false
:listchars  { :eol  "↲" :tab  "▸ " :trail  "·" }
:mouse  "a"
:nrformats  [ :alpha :octal :hex ]
:number  true
:numberwidth  3
:relativenumber  true
:scrolloff  10
:shell  "zsh"
:shiftround  true
:shiftwidth  2
:showbreak  "↪"
:showtabline  0
:showmatch  true
:showmode  false
:signcolumn  :yes
:smartcase  true
:smartindent  true
:sidescrolloff  10
:softtabstop  2
:splitbelow  true
:splitright  true
:swapfile  false
:tabstop  2
:termguicolors  true
:timeoutlen  200
:title  true
:textwidth  80
:updatetime  150
:undofile  true
:virtualedit  [ :block ]
:wildmode  [ :list :longest ]
:wildoptions  :pum
:winblend  0
:wrap  false
:writebackup  false
:pumheight  10
:pumblend  5
})

(each [key value (pairs options)]
  (util.opt key value))
