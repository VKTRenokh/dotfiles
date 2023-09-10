(local {: autoload} (require :nfnl.module))
(local uu (autoload :config.util))
(local {: mason} (. (autoload :config.constants) :ensure_installed))
(local {: lua_ls } (autoload :config.constants))

[(uu.tx :williamboman/mason.nvim
       {:opts {:ui {:border :rounded
                    :icons { :package_installed "◍" :package_pending "◍" :package_uninstalled "◍"}}
               :log_level vim.log.levels.INFO    
               :max_concurrent_installers 5      
               :ensure_installed mason}
        :cmd :Mason
        :config (fn [_ opts] 
                  ((. (autoload :mason) :setup) opts)
                  (let [mr (autoload :mason-registry)]
                    (each [_ tool (ipairs opts.ensure_installed)]
                      (let [p (mr.get_package tool)]
                        (when (not (p:is_installed))
                          (p:install))))))})
 (uu.tx :neovim/nvim-lspconfig
        {:event [:BufReadPre :BufNewFile]
         :dependencies [{1 :folke/neoconf.nvim :cmd :Neoconf :config true}
                        {1 :folke/neodev.nvim :opts {:experimental {:pathStrict true}}}
                        :mason.nvim
                        :williamboman/mason-lspconfig.nvim
                        {1 :hrsh7th/cmp-nvim-lsp
                         :cond (fn []
                                 ((. (autoload :lazyvim.util) :has) :nvim-cmp))}
                        :SmiteshP/nvim-navic]
         :opts {:diagnostics {:underline true 
                              :update_in_insert false
                              :virtual_text {:spacing 4 :prefix :●}
                              :severity_sort true}}
                :autoformat true
                :format {:formatting_options nil
                         :timeout_ms nil}
                :servers {:lua_ls {:settings {:Lua lua_ls.Lua}}}
        :config (fn [])})]
