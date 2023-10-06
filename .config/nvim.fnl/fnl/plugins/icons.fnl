(local {: autoload} (require :nfnl.module))
(local uu (autoload :config.util))
(local {: icons} (autoload :config.constants))

(uu.tx :nvim-tree/nvim-web-devicons
       {:opts {:override icons.web_devicons}})
