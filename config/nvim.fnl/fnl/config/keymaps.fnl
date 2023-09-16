(local {: autoload} (require :nfnl.module))

(local {: keymap} (autoload :config.util))

;{{{ Splits
(keymap :n :<leader> :<C-w>w)
(keymap :n :sv :vsplit)
(keymap :n :<leader>s :split<>)
;}}}
; {{{ Better window navigation
(keymap :n :<C-h> :<C-w>h)
(keymap :n :<C-j> :<C-w>j)
(keymap :n :<C-k> :<C-w>k)
(keymap :n :<C-l> :<C-w>l)
; }}}
;{{{ Resize with arrows
(keymap :n :<C-Up> ":resize -2")
(keymap :n :<C-Down> ":resize +2")
(keymap :n :<C-Left> ":vertical resize -2")
(keymap :n :<C-Right> ":vertical resize +2")
;}}}
;{{{ Navigate buffers
(keymap :n :<S-h> :bprev)
(keymap :n :<S-l> :bnext)
;}}}
;{{{ Inc and dec numbers
(keymap :n :+ :<C-a>)
(keymap :n :- :<C-x>)
;}}}
;{{{ Select (charwise) the contents of the current line, excluding indentation
(keymap :n :vv :^vg_)
;}}}
;{{{ Select entire buffer
(keymap :n :<C-a> :ggVG)
(keymap :n :<leader>V "V`]")
;}}}
;{{{ Save all files
(keymap :n :<F2> :wall)
;}}}
;{{{ Delete current buffer
(keymap :n :Q :Bdelete!)
;}}}
;{{{ Toggle [in]visible characters
(keymap :n :<leader>i "set list!")
;}}}
;{{{ Stay in indent mode
(keymap :v :< :<gv)
(keymap :v :> :>gv)
;}}}
;{{{ Visual yank
(keymap :v :<leader>cc "\"+y")
;}}}
;{{{ Obfuscate
(keymap :n :<F3> "mmggg?G`m")
;}}}
;{{{ Delete
(keymap :n :<leader>d "\"_d")
(keymap :n :<leader>d "\"_d")
;}}}
;{{{ Move text up and down
(keymap "v" "<A-j>" ":m .+1<CR>==")
(keymap "v" "<A-k>" ":m .-2<CR>==")
(keymap "v" "p" "\"_dP")
(keymap "x" "J" ":m '>+1<CR>gv-gv")
(keymap "x" "K" ":m '<-2<CR>gv-gv")
(keymap "x" "<A-j>" ":m '>+1<CR>gv-gv")
(keymap "x" "<A-k>" ":m '<-2<CR>gv-gv")
;}}}
;{{{ Folding commands
(keymap :n :zv :zMzvzz)
(keymap :n :zk :zckzOzz)
(keymap :n :zj :zcjzOzz)
;}}}
;{{{ Keep the cursor in place while joinging lines
(keymap :n :J "mzJ`z")
(keymap :n :<leader>J "myvipJ`ygq")
;}}}
;{{{ Quit all
(keymap :n :<c-q> :qall!)
(keymap :n :<leader>qq :qall!)
;}}}
;{{{ leader + space
(keymap :n :<leader><space> :nohlsearch)
;}}}
;{{{ Help
(keymap :n :<leader>HH "silent vert bo help")
;}}}
;{{{ Linewise reselection of what you just pasted
(keymap :n :<leader>VV "V`]")
;}}}
