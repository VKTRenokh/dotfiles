(local {: autoload} (require :nfnl.module))
(local fun (autoload :config.fun))
(local {: update } (autoload :nfnl.core))

(fn +docs [opts to]
  (update opts :desc (fn [desc] (or desc to))))

(fn keymap [modes from to opts]
  (var options {:silent true :noremap true})
  (let [opts  (if
                (= (type opts) "table")  (vim.tbl_deep_extend :force options opts)
                (= (type opts) "string") {:desc opts})]
    (vim.keymap.set modes from to (+docs opts to))))

(fn vis-op+ [op args]
  #(op
     [(vim.api.nvim_buf_get_mark 0 "<")
      (vim.api.nvim_buf_get_mark 0 ">")]
     args))

(fn +buffer [opts buffer]
  (update opts :buffer (fn [b] (or b buffer))))

(fn bkset [modes from to opts]
  (let [opts  (if
                (= (type opts) "table")  (+buffer opts 0)
                (= (type opts) "number") {:buffer opts}
                (= (type opts) "string") {:desc opts}
                {:buffer 0})]
    (vim.keymap.set modes from to (+docs opts to))))

(fn opt [key value]
  "Set a vim option"
  (tset vim.opt key value))

(fn g [key value]
  "Set a vim option"
  (tset vim.g key value))

(fn last [xs]
  (fun.nth (fun.length xs) xs))

(fn colorscheme [name]
  "Set the current colorscheme"
  (vim.cmd (.. "colorscheme " name)))

(fn tx [...]
  (let [args [...]
        len (fun.length args)]
    (if (= :table (type (last args)))
      (fun.reduce
        (fn [acc n v]
          (tset acc n v)
          acc)
        (last args)
        (fun.zip (fun.range 1 len) (fun.take (- len 1) args)))
      args)))

(fn autocmd [cmd table]
  (vim.api.nvim_create_autocmd cmd table))

(fn has [plugin]
  (not= (. (. (require :lazy.core.config) :plugins) plugin) nil))

(fn on-very-lazy [function]
  (autocmd :User {:pattern :VeryLazy :callback (fn [] (function))}))

(fn on-attach [on_attach]
  (autocmd "LspAttach" {:callback (fn [args]
                                    (let [buffer args.buf
                                          client (vim.lsp.get_client_by_id args.data.client_id)]
                                      (on_attach client buffer)))}))
(fn augroup [name]
  (vim.api.nvim_create_augroup (.. :vktr name) {:clear true}))

(fn opts [name]
  (let [plugin (. (. (require :lazy.core.config) :plugins) name)]
    (when (not plugin)
      (let [___antifnl_rtn_1___ {}] (lua "return ___antifnl_rtn_1___")))
    (local Plugin (require :lazy.core.plugin))
    (Plugin.values plugin :opts false)))

{: opt
 : colorscheme
 : g
 : opts
 : keymap
 : autocmd
 : has
 : vis-op+
 : bkset
 : on-very-lazy
 : on-attach
 : augroup
 : tx }
