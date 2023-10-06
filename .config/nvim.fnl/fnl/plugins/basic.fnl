(local {: autoload} (require :nfnl.module))
(local {: tx} (autoload :config.util))

[(tx :kovetskiy/sxhkd-vim {:ft :sxhkd})
 (tx :dkarter/bullets.vim {:ft :markdown})
 (tx :NvChad/nvim-colorizer.lua {:event [:BufReadPost :BufNewFile] :config true})
 (tx :nvim-lua/popup.nvim {:event :VimEnter})
 (tx :xiyaowong/virtcolumn.nvim {:event [:BufReadPost :BufNewFile]})
 (tx :nvim-lua/plenary.nvim)]
