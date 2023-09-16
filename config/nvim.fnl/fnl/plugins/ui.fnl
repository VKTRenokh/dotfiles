(local {: autoload} (require :nfnl.module))
(local {: tx} (autoload :config.util))

[(tx :folke/todo-comments.nvim
     {:cmd [:TodoTrouble :TodoTelescope]
      :event [:BufReadPost :BufNewFile]
      :config true
      :keys [{1 "]t" 2 (fn []
                         ((. (require :todo-comments) :jump_next)))}
                {1 "[t" 2 (fn []
                         ((. (require :todo-comments) :jump_prev)))}
                {1 "<leader>xt" 2 "<cmd>TodoTrouble<cr>"}
                {1 "<leader>xT" 2 "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>"}
                {1 ";td" 2 "<cmd>TodoTelescope<cr>"}
                {1 ";tD" 2 "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>"}]})
 (tx :folke/trouble.nvim
     {:keys [{1 "<leader>LR" 2 "<cmd>TroubleToggle lsp_references<cr>" :desc "open trouble with lsp references"}
             {1 "<leader>Ld" 2 "<cmd>TroubleTOggle lsp_document_symbols<cr>" :desc "open trouble with lsp symbols"}]
      :opts {:use_diagnostic_signs true}})
 (tx :iamcco/markdown-preview.nvim
     {:ft :markdown
      :config (fn []
                ((. (vim.fn) "mkdp#util#install")))})
 (tx :lewis6991/gitsigns.nvim
     {:event :BufReadPre
      :opts {:signs {:add {:text "▎"}
                     :change {:text "▎"}
                     :delete {:text "契" }
                     :topdelete {:text "契" }
                     :changedelete {:text "▎"}
                     :untracked {:text "▎"}}
             :signcolumn true
             :numhl true
             :linehl false
             :word_diff false
             :watch_gitdir {:interval 1000
                            :follow_files true}
             :attach_to_untracked true
             :current_line_blame true
             :current_line_blame_opts {:virt_text true
                                       :virt_text_pos :eol
                                       :delay 1000
                                       :ignore_whitespace false}
             :current_line_blame_formatter_opts {:relative_time false}
             :sign_priority 6
             :update_debounce 100
             :max_file_length 40000
             :preview_config {:border :rounded
                              :style :minimal
                              :relative :cursor
                              :row 0
                              :col 1}
             :yadm {:enable false}}})
 (tx :stevearc/dressing.nvim
     {:init (fn []
              (set vim.ui.select (fn [...]
                                    (let [args [...]]
                                      ((. (autoload :lazy) :load) {:plugins [:dressing.nvim]})
                                      (vim.ui.select args))))
              (set vim.ui.input (fn [...]
                                   (let [args [...]]
                                     ((. (autoload :lazy) :load) {:plugins [:dressing.nvim]})
                                     (vim.ui.input args)))))})]
