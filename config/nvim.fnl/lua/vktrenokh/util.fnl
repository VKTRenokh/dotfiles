(local fun (require :vktrenokh.vendor.fun))

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

(fn keymap [mode key command]
 (vim.api.nvim_set_keymap mode key command {:silent true :noremap true}))

(fn autocmd [cmd table]
  (vim.api.nvim_create_autocmd cmd table))

{: opt
 : colorscheme
 : g
 : keymap
 : autocmd
 : tx }
