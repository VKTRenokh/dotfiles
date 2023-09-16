(local {: autoload} (require :nfnl.module))

(local {: tx} (autoload :config.util))

[(tx :tpope/vim-fugitive
     {:dependencies [:tpope/vim-rhubarb]
      :keys [{1 :<leader>g 2 :<cmd>G<cr> :desc "Open vim fugitive"}]})
 (tx :karb94/neoscroll.nvim
     {:keys [:zt :zz :zb :<C-u> :<C-d> :<C-b> :<C-f> :<C-y> :<C-e>]
      :opts {:mappings [:zt :zz :zb :<C-u> :<C-d> :<C-b> :<C-f> :<C-y> :<C-e>]}
      :config (fn [_ opts]
                ((. (require :neoscroll) :setup) opts))})
 (tx :akinsho/toggleterm.nvim
     {:cmd :ToggleTerm
      :version :*
      :opts {:size 13
             :open_mapping :<c-\>
             :shade_filetypes []
             :shade_terminals true
             :shading_factor 1
             :start_in_insert true
             :persist_size true
             :direction :horizontal}})]
