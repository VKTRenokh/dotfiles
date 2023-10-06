(local {: autoload} (require :nfnl.module))
(local {: tx : keymap} (autoload :config.util))

(local english "asdfghjklqwertyuiopzxcvbnm")

[(tx :numToStr/Comment.nvim
    {:keys [{1 :gcc 2 ""}
            {1 :gbc 2 ""}
            {1 :gc 2 ""}
            {1 :gc0 2 ""}
            {1 :gco 2 ""}
            {1 :gcA 2 ""}]
     :opts {:padding true
            :sticky true
            :ignore nil
            :toggler {:line :gcc
                      :block :gbc}
            :opleader {:line :gc
                       :block :gbc}
            :extra {:above :gc0
                    :below :gco
                    :eol :gcA}
            :mappings {:basic true
                       :extra true}
            :pre_hook nil
            :post_hook nil}})
 (tx :mg979/vim-visual-multi
     {:keys [{1 :<c-down> :desc "vim visual multi add new cursor below"}
             {1 :<C-n> :desc "Vim visual multi select next word"}
             {1 :<c-down> :desc "vim visual multi add new cursor above"}]})
 (tx :folke/flash.nvim
     {:keys [{1 :<leader>/ 2 (fn []
                     ((. (require :flash) :jump))) :mode [:n :x :o]}]
      :opts {:lables english
             :modes {:char {:enabled false}
                     :search {:enabled true
                              :search {:enabled true
                                       :incremental true}}
                     :treesitter {:enabled false}}
             :label {:uppercase false
                     :rainbow {:enabled false
                               :shade 5}
                     :after false
                     :before true
                     :style :inline}}
      :config true})
 ]

