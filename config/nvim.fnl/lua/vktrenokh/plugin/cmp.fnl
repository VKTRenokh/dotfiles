(local uu (require :vktrenokh.util))
(local icons (. (require :config.constants) :icons))
(local completion (. (require :config.constants) :completion))

[(uu.tx :hrsh7th/nvim-cmp
       {:event :InsertEnter
        :version false
        :dependencies [:hrsh7th/cmp-buffer
                       :hrsh7th/cmp-calc
                       :hrsh7th/cmp-cmdline
                       :hrsh7th/cmp-nvim-lua
                       :hrsh7th/cmp-nvim-lsp-document-symbol
                       :hrsh7th/cmp-nvim-lsp
                       :hrsh7th/cmp-path
                       :saadparwaiz1/cmp_luasnip]
        :opts (fn [_ opts]
                (let [cmp (require :cmp)
                      luasnip (require :luasnip)
                      check_backspace (fn []
                                        (let [col (- (vim.fn.col :. ) 1)]
                                          (or (= col 0) (: (: (vim.fn.getline ".") :sub col col) :match "%s"))))
                      comp {:completeopt "menu,menuone,noselect" :keyword_length 1}
                      snippet {:expand (fn [args] (luasnip.lsp_expand args.body))}
                      formatting {:fields [:kind :abbr :menu] :format (fn [entry vim_item]
                                                                        (set vim_item.kind (string.format :%s (. icons.kind vim_item.kind)))
                                                                        (set vim_item.menu (. completion.source_mapping entry.source.name))
                                                                             vim_item)}
                      confirm_opts {:behavior cmp.ConfirmBehavior.Replace :select false}
                      mapping {:<C-Space> (cmp.mapping (cmp.mapping.complete) [:i :c])
                      :<C-b> (cmp.mapping (cmp.mapping.scroll_docs (- 2)) [:i :c])
                      :<C-e> (cmp.mapping {:c (cmp.mapping.close)
                                          :i (cmp.mapping.abort)})
                      :<C-f> (cmp.mapping (cmp.mapping.scroll_docs 2) [:i :c])
                      :<C-j> (cmp.mapping.select_next_item)
                      :<C-k> (cmp.mapping.select_prev_item)
                      :<C-y> cmp.config.disable
                      :<CR> (cmp.mapping.confirm {:select true})
                      :<S-Tab> (cmp.mapping (fn [fallback]
                                              (if (cmp.visible)
                                                  (cmp.select_prev_item)
                                                  (luasnip.jumpable (- 1))
                                                  (luasnip.jump (- 1)) (fallback)))
                                            [:i :s])
                      :<Tab> (cmp.mapping (fn [fallback]
                                            (if (cmp.visible) (cmp.select_next_item)
                                                (luasnip.expandable) (luasnip.expand)
                                                (luasnip.expand_or_jumpable)
                                                (luasnip.expand_or_jump)
                                                (check-backspace) (fallback)
                                                (fallback)))
                                          [:i :s])}
                      window {:completion (cmp.config.window.bordered) :documentation (cmp.config.window.bordered)}
                      experimental {:ghost_text true}
                      ] 
                  (cmp.setup.filetype :gitcommit {:sources (cmp.config.sources [{:name :cmp_git}] [{:name :buffer}])})
                  (cmp.setup.cmdline :: {:mapping (cmp.mapping.preset.cmdline) :sources (cmp.config.sources [{:name :path}] [{:name :cmdline}])})
                  (cmp.setup.cmdline [:/ :?] {:mapping (cmp.mapping.preset.cmdline) :sources (cmp.config.sources [{:name :buffer}])})
                  (set opts.completion comp)
                  (set opts.snippet snippet)
                  (set opts.formatting formatting)
                  (set opts.confirm_opts confirm_opts)
                  (set opts.sources completion.sources)
                  (set opts.window window)
                  (set opts.experimental experimental)
                  (set opts.mapping mapping)))
       })
 (uu.tx :L3MON4D3/LuaSnip
        {:dependencies {1 :rafamadriz/friendly-snippets
                        :config (fn [] ((. (require :luasnip.loaders.from_vscode) :lazy_load)))}
         :opts {:history true :delete_check_events :TextChanged}})]
