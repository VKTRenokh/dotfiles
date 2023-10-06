(local {: autoload} (require :nfnl.module))
(local uu (autoload :config.util))

(uu.tx :windwp/nvim-autopairs
       {:event [:BufReadPost :BufNewFile]
       :opts {:disable_filetype
       [:clojure :scheme :lisp :timl :fennel :janet :racket]}
         :config true}
       )
