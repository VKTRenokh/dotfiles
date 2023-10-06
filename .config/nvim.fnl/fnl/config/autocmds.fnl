(local {: autoload} (require :nfnl.module))
(local {: autocmd : augroup : keymap} (autoload :config.util))
;{{{ Clear items that make transparency look bad
(autocmd :BufEnter
         {:callback (fn []
                      (vim.cmd "highlight Folded guibg=NONE")
                      (vim.cmd "highlight ColorColumn guibg=#292d42")
                      (vim.cmd "highlight LineNr guifg=#e0af68")
                      (vim.cmd "highlight LineNrAbove guifg=#787c99")
                      (vim.cmd "highlight LineNrBelow guifg=#787c99"))})
;}}}
;{{{ Close some filetypes with <q>
(autocmd :filetype {:pattern [
                              :alpha
                              :PlenaryTestPopup
                              :dashboard
                              :fugitive
                              :help
                              :lspinfo
                              :man
                              :mason
                              :notify
                              :qf
                              :spectre_panel
                              :startuptime
                              :tsplayground]
         :callback (fn [event]
                     (tset (. vim.bo event.buf) :buflisted false)
                     (keymap :n :q :<cmd>close<cr> {:buffer event.buf :silent true}))})
;}}}
;{{{ Format options
(autocmd :BufEnter {:callback (fn []
		(vim.cmd"setlocal formatoptions+=c ")
		(vim.cmd"setlocal formatoptions+=j ")
		(vim.cmd"setlocal formatoptions+=n ")
		(vim.cmd"setlocal formatoptions+=q ")
		(vim.cmd"setlocal formatoptions+=r ")
		(vim.cmd"setlocal formatoptions-=2 ")
		(vim.cmd"setlocal formatoptions-=a ")
		(vim.cmd"setlocal formatoptions-=o ")
		(vim.cmd"setlocal formatoptions-=t "))})
;}}}
;{{{ Goto last location when opening a buffer
(autocmd :BufReadPost {:callback (fn []
                                   (let [mark (vim.api.nvim_buf_get_mark 0 "\"")
                                         lcount (vim.api.nvim_buf_line_count 0)]
                                     (when (and (> (. mark 1) 0) (<= (. mark 1) lcount))
                                       (pcall vim.api.nvim_win_set_cursor 0 mark))))})
;}}}
;{{{ Highlight on yank
(let [highlight_group (augroup :YankHighlight {:clear true})]
  (autocmd :TextYankPost
           {:callback (fn []
                        (vim.highlight.on_yank))
            :group highlight_group
            :pattern "*"}))
;}}}
;{{{ Json
(let [json_group (augroup :Json {:clear true})]
  (autocmd [:BufRead :BufNewFile] {:command "syntax match Comment +\\/\\/.\\+$+"
                                   :group json_group
                                   :pattern "*.json"}))
;}}}
;{{{ Reload file when necessary
(autocmd [:FocusGained :TermClose :TermLeave] {:command :checktime})
;}}}
;{{{ Resize splits when window is resized
(autocmd :VimResized {:callback (fn []
                                  (vim.cmd "tabdo wincmd ="))})
;}}}
;{{{ Set spelling for some file types
(autocmd :FileType {:pattern [:gitcommit :markdown :wiki]
                    :callback (fn []
                                (set vim.opt_local.spell true))})
;}}}
;{{{ Whitespace
(let [whitespace_group (augroup :WhiteSpace {:clear true})]
  (autocmd :BufWritePre {:command "%s/\\s\\+$//e"
                         :group whitespace_group}))
;}}}
