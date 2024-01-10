(local {: autoload} (require :nfnl.module))
(local {: some} (autoload :nfnl.core))
(local nvim (autoload :nvim))
(local {: autocmd : g : tx : augroup} (autoload :config.util))

(local lisps [:clojure :scheme :lisp :cl :timl :fennel :janet])

(tx :gpanders/nvim-parinfer
    {:ft lisps
     :config #(g :parinfer_force_balance true)})
