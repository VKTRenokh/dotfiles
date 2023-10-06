(local {: autoload} (require :nfnl.module))
(local uu (autoload :config.util))

(uu.tx :akinsho/bufferline.nvim
       {:keys [{1 :te 2 :<cmd>:tabedit<cr> :desc "Create New Tab"}]
       :opts {:options {:mode :tabs
                        :separator_style :thin
                        :show_buffer_close_icons false
                        :color_icons false
                        :always_show_bufferline false
                        :highlights {:background {:fg :#616161}
                                        :buffer_selected {:fg :#f1f1f1
                                                        :bold false
                                                        :italic true}}}}
        :config (fn [_ opts]
                  (let [bufferline (autoload :bufferline)]
                    (bufferline.setup opts)
                    (uu.keymap :n :<S-Tab> :<cmd>:tabprev<cr>)
                    (uu.keymap :n :<Tab> :<cmd>:tabnext<cr>)))})
