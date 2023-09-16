(local {: autoload} (require :nfnl.module))
(local uu (autoload :config.util))
(local {: mason} (. (autoload :config.constants) :ensure_installed))
(local {: lua_ls } (autoload :config.constants))
(local {: icons} (autoload :config.constants))

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
         :dependencies [{1 :folke/neoconf.nvim :enabled false :cmd :Neoconf :config true}
                        {1 :folke/neodev.nvim :enabled false :opts {:experimental {:pathStrict true}}}
                        :mason.nvim
                        :williamboman/mason-lspconfig.nvim
                        {1 "RRethy/vim-illuminate" :enabled false}
                        {1 :hrsh7th/cmp-nvim-lsp
                         :cond (fn []
                                 ((. (autoload :config.util) :has) :nvim-cmp))}
                        :SmiteshP/nvim-navic]
         :opts {:diagnostics {:underline true
                              :update_in_insert false
                              :virtual_text {:spacing 4 :prefix :●}
                              :severity_sort true}
                :autoformat true
                :inlay_hints {:enable false}
                :format {:formatting_options nil
                         :timeout_ms nil}
                :servers {:lua_ls {:settings {:Lua lua_ls.Lua}}}
                :setup {}}
        :config (fn [_ opts]
                  (let [on-attach (. (require :plugins.lsp.format) :on_attach)
                                  icons (. (require :config.constants) :icons)]
                    (tset (require :plugins.lsp.format) :autoformat
                          opts.autoformat)
                    ((. (require :config.util) :on-attach) (fn [client buffer]
                                                             ((. (require :plugins.lsp.format)
                                                                 :on_attach) client
                                                              buffer)
                                                             ((. (require :plugins.lsp.keymaps)
                                                                 :on_attach) client
                                                              buffer)
                                                             nil))
                    (local register-capability
                           (. vim.lsp.handlers :client/registerCapability))
                    (tset vim.lsp.handlers :client/registerCapability
                          (fn [err res ctx]
                            (let [ret (register-capability err res ctx)
                                      client-id ctx.client_id
                                      client (vim.lsp.get_client_by_id client-id)
                                      buffer (vim.api.nvim_get_current_buf)]
                              ((. (require :plugins.lsp.keymaps) :on_attach) client
                                                                             buffer)
                              ret)))
                    (each [name icon (pairs icons.diagnostics)]
                      (set-forcibly! name (.. :DiagnosticSign name))
                      (vim.fn.sign_define name
                                          {:numhl "" :text icon :texthl name}))
                    (local inlay-hint
                           (or vim.lsp.buf.inlay_hint vim.lsp.inlay_hint))
                    (when (and opts.inlay_hints.enabled inlay-hint)
                      (on-attach (fn [client buffer]
                                   (when (client.supports_method :textDocument/inlayHint)
                                     (inlay-hint buffer true)))))
                    (when (and (= (type opts.diagnostics.virtual_text) :table)
                               (= opts.diagnostics.virtual_text.prefix :icons))
                      (set opts.diagnostics.virtual_text.prefix
                           (or (and (= (vim.fn.has :nvim-0.10.0) 0) "●")
                               (fn [diagnostic]
                                 (each [d icon (pairs icons)]
                                   (when (= diagnostic.severity
                                            (. vim.diagnostic.severity (d:upper)))
                                     (lua "return icon")))))))
                    (vim.diagnostic.config (vim.deepcopy opts.diagnostics))
                    (local servers opts.servers)
                    (local (has-cmp cmp-nvim-lsp) (pcall require :cmp_nvim_lsp))
                    (local capabilities
                           (vim.tbl_deep_extend :force {}
                                                (vim.lsp.protocol.make_client_capabilities)
                                                (or (and has-cmp
                                                         (cmp-nvim-lsp.default_capabilities))
                                                    {})
                                                (or opts.capabilities {})))

                    (fn setup [server]
                      (let [server-opts (vim.tbl_deep_extend :force
                                                             {:capabilities (vim.deepcopy capabilities)}
                                                             (or (. servers
                                                                    server)
                                                                 {}))]
                        (if (. opts.setup server)
                            (when ((. opts.setup server) server server-opts)
                              (lua "return "))
                            (. opts.setup "*")
                            (when ((. opts.setup "*") server server-opts)
                              (lua "return ")))
                        ((. (. (require :lspconfig) server) :setup) server-opts)))

                    (local (have-mason mlsp) (pcall require :mason-lspconfig))
                    (var all-mslp-servers {})
                    (when have-mason
                      (set all-mslp-servers
                           (vim.tbl_keys (. (require :mason-lspconfig.mappings.server)
                                            :lspconfig_to_package))))
                    (local ensure-installed {})
                    (each [server server-opts (pairs servers)]
                      (when server-opts
                        (set-forcibly! server-opts
                                       (or (and (= server-opts true) {})
                                           server-opts))
                        (if (or (= server-opts.mason false)
                                (not (vim.tbl_contains all-mslp-servers server)))
                            (setup server)
                            (tset ensure-installed
                                  (+ (length ensure-installed) 1) server))))
                    (when have-mason
                      (mlsp.setup {:ensure_installed ensure-installed
                                  :handlers [setup]}))))})
 (uu.tx :jose-elias-alvarez/null-ls.nvim
     {:event [:BufReadPre :BufNewFile]
      :dependencies :williamboman/mason.nvim
      :opts (fn []
              (let [nls (require :null-ls)]
                {:root_dir ((. (require :null-ls.utils) :root_pattern) :.null-ls-root :.neoconf.json :Makefile :.git)
                 :sources [nls.builtins.formatting.stylua
                           nls.builtins.formatting.prettierd
                           ]}))})
 (uu.tx :simrat39/symbols-outline.nvim
        {:keys [[:<leader>o :<cmd>SymbolsOutline<cr>]]
         :cmd :SymbolsOutline
         :opts {:highlight_hovered_item true
			:highlight_hovered_item true
			:show_guides true
			:auto_preview false
			:position "right"
			:relative_width true
			:width 45
			:auto_close false
			:show_numbers false
			:show_relative_numbers false
			:show_symbol_details true
			:preview_bg_highlight "Pmenu"
			:autofold_depth nil
			:auto_unfold_hover true
			:fold_markers { "" "" }
			:wrap false
      :keymaps {:close { "<Esc>" "q" }
				        :goto_location "<Cr>"
				        :focus_location "o"
				        :hover_symbol "<C-space>"
				        :toggle_preview "K"
				        :rename_symbol "r"
				        :code_actions "a"
				        :fold "h"
				        :unfold "l"
				        :fold_all "W"
				        :unfold_all "E"
				        :fold_reset "R"}
      :lsp_blacklist []
      :symbol_blacklist []
      :symbols {:File { :icon icons.kind.File :hl "@text.uri" }
				        :Module { :icon icons.kind.Module :hl "@namespace" }
				        :Namespace { :icon icons.type.Array :hl "@namespace" }
				        :Package { :icon icons.misc.Package :hl "@namespace" }
				        :Class { :icon icons.kind.Class :hl "@type" }
				        :Method { :icon icons.kind.Method :hl "@method" }
				        :Property { :icon icons.kind.Property :hl "@method" }
				        :Field { :icon icons.kind.Field :hl "@field" }
				        :Constructor { :icon icons.kind.Constructor :hl "@constructor" }
				        :Enum { :icon icons.kind.Enum :hl "@type" }
				        :Interface { :icon icons.kind.Interface :hl "@type" }
				        :Function { :icon icons.kind.Function :hl "@function" }
				        :Variable { :icon icons.kind.Variable :hl "@constant" }
				        :Constant { :icon icons.kind.Constant :hl "@constant" }
				        :String { :icon icons.kind.Struct :hl "@string" }
				        :Number { :icon icons.kind.Number :hl "@number" }
				        :Boolean { :icon icons.kind.Boolean :hl "@boolean" }
				        :Array { :icon icons.type.Array :hl "@constant" }
				        :Object { :icon icons.type.Object :hl "@type" }
				        :Key { :icon "🔐" :hl "@type" }
				        :Null { :icon "NULL" :hl "@type" }
				        :EnumMember { :icon icons.kind.EnumMember :hl "@field" }
				        :Struct { :icon icons.kind.Struct :hl "@type" }
				        :Event { :icon icons.kind.Event :hl "@type" }
				        :Operator { :icon icons.kind.Operator :hl "@operator" }
				        :TypeParameter { :icon icons.kind.TypeParameter :hl "@parameter" }
				        :Component { :icon icons.type.Array :hl "@function" }
				        :Fragment { :icon icons.type.Array :hl "@constant" }}}})]
