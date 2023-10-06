(local {: autoload} (require :nfnl.module))
(local {: tx : colorscheme : g} (autoload :config.util))

[(tx :mcchrish/zenbones.nvim
    {:lazy true
     :enabled false
     :priority 1000
     :dependencies :rktjmp/lush.nvim
     :config (fn [] (colorscheme :zenbones))})
 (tx :VKTRenokh/nvim-base16
     {:lazy false
      :priority 1000
      :config (fn [] (colorscheme :base16-tokyo-night-terminal-storm))})
 (tx :kovetskiy/sxhkd-vim
     {:ft :sxhkd})]
