(local uu (require :vktrenokh.util))

[(uu.tx
   :folke/tokyonight.nvim
   {:lazy false
   :opts {
        :transparent true
        :style :moon
        :styles {
                :sidebars :transparent
                :floats :transparent}}
   :config (fn [_ opts] 
             (let [tokyonight (require :tokyonight)]
             (tokyonight.setup opts)
             (uu.colorscheme :tokyonight)))})]
