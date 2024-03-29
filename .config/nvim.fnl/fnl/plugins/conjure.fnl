(local {: autoload} (require :nfnl.module))
(local uu (autoload :config.util))

(uu.tx
  :Olical/conjure
  {:ft [:clojure :scheme :lisp :cl :timl :fennel :janet]
  :config (fn [_ opts]
            (let [cjmain (autoload :conjure.main)
                   cjmap (autoload :conjure.mapping)]
              (cjmain.main)
              (cjmap.on-filetype)
              nil))
  :init (fn []
          (uu.g :conjure#debug true))}
  )
