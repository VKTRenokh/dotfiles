(local uu (require :vktrenokh.util))

(uu.tx
  :Olical/conjure
  {:ft ["clojure" "fennel" "python"]
  :config (fn [_ opts]
            (let [cjmain (require :conjure.main)
                   cjmap (require :conjure.mapping)]
              (cjmain.main)
              (cjmap.on-filetype)
              nil))
  :init (fn []
          (uu.g :conjure#debug true))}
  )
