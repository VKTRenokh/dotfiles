(local {: autoload} (require :nfnl.module))
(local uu (autoload :config.util))

[(uu.tx
   :folke/tokyonight.nvim
   {:lazy true
    :opts {
        :transparent true
        :style :moon
        :styles {
                :sidebars :transparent
                :floats :transparent}}
    :config (fn [_ opts]
             (let [tokyonight (autoload :tokyonight)]
             (tokyonight.setup opts)
             (uu.colorscheme :tokyonight)))})]
