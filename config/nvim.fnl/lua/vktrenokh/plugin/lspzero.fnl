(local uu (require :vktrenokh.util))

(uu.tx :VonHeikemen/lsp-zero.nvim
       {:config (fn []
                  (let [lsp ((. (require :lsp-zero) :preset) {})]
                    (lsp.on_attach (fn [client bufnr]
                                     (lsp.default_keyamps {:buffer bufnr})))))})
