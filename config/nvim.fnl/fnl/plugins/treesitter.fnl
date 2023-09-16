(local {: autoload} (require :nfnl.module))
(local uu (autoload :config.util))

(local disabled [:html :latex :markdown])
(local ensure_installed [:bash :c :cpp :css :dockerfile :html :javascript :json :lua :markdown :markdown_inline :python :query :regex :rust :tsx :typescript :vim :yaml])
  (local rainbow [:Orchid :DodgerBlue :Cornsilk :Salmon :LawnGreen :Gold])

[(uu.tx :nvim-treesitter/nvim-treesitter
       {:event ["BufReadPost" "BufNewFile"] :version false
       :build ":TSUpdate"
       :keys [{1 :<c-space> :desc "Increment selection"} {1 :<bs> :desc "Decrement selection"}]
       :opts {
              :autopairs { :enable true }
              :autotag { :enable true :disable ["xml"]}
              :autoinstall true
              :context_commenting {:enable true :enable_autocmd false}
              :highlight {:enable true :disable disabled :additional_vim_regex_highlighting false}
              :indent {:enable true :disable [:yml :yaml]}
              :rainbow {:enable false :extended_mode true :max_file_lines nil :colors rainbow}
              :textobjects {:select {:enable true
                            :lookahead true
                            :keymaps {:af "@function.outer"
                                      :af "@function.inner"
                                      :ac "@class.outer"
                                      :ic "@class.inner"}}
                            :selection_modes {}
                            :include_surrounding_whitespace true}

              :disable [:latex]
              :ensure_installed ensure_installed
              :setup {}
              :incremental_selection {:enable true :keymaps {:init_selection :<C-space> :node_incremental :<C-space> :scope_incremental :<nop> :node_decremental :<bs>}}}
       :config (fn [_ opts]
                 (let [config (autoload :nvim-treesitter.configs)]
                   (config.setup opts)))
       :dependencies [:windwp/nvim-ts-autotag :mrjones2014/nvim-ts-rainbow :JoosepAlviste/nvim-ts-context-commentstring
                                              {1 :nvim-treesitter/nvim-treesitter-textobjects
                                                 :opts {}
                                              :init (fn []
                                                      (let [plugin (. (. (. (autoload :lazy.core.config) :spec) :plugins) :nvim-treesitter)
                                                                 opts ((. (require :lazy.core.plugin) :values) plugin :opts false)]
                                                        (var enabled false)
                                                        (when opts.textobjects
                                                          (each [_ mod (ipairs [:move :select :swap :lsp_interop])]
                                                            (when (and (. opts.textobjects mod) (. (. opts.textobjects mod) :enable))
                                                              (set enabled true)
                                                              (lua :break))))
                                                        (when (not enabled)
                                                          ((. (require :lazy.core.loader) :disable_rtp_plugin) :nvim-treesitter-textobjects))))
                                              :config (fn [] nil)}]})
 (uu.tx :mrjones2014/nvim-ts-rainbow
       {:event [:BufReadPost :BufNewFile]})]
