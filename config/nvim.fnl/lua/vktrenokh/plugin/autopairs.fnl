(local uu (require :vktrenokh.util))

(uu.tx :windwp/nvim-autopairs
       {:event [:BufReadPost :BufNewFile]
       :config true})
