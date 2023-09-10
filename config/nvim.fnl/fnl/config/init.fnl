(local {: autoload} (require :nfnl.module))

;; open Help in full window
(vim.api.nvim_command "command! -nargs=1 -complete=help H help <args> | silent only")

;; restore last known position
(vim.api.nvim_create_autocmd
  :BufReadPost
  {:pattern :*
   :group (vim.api.nvim_create_augroup :LastPosition {:clear true})
   :callback #(vim.cmd "if line(\"'\\\"\") > 1 && line(\"'\\\"\") <= line(\"$\") | exe \"normal! g'\\\"\" | endif")})

;; handy setting to update opened files after switching branch
(set vim.o.autoread true)
(vim.api.nvim_create_autocmd
  "FocusGained,BufEnter,CursorHold"
  {:pattern "*"
   :group (vim.api.nvim_create_augroup :AutoChecktime {:clear true})
   :callback #(vim.cmd "silent! checktime")})

(fn compare-to-clipboard []
  (let [ftype (vim.api.nvim_eval "&filetype")]
    (->
      "execute 'normal! \"xy'
      tabnew
      vsplit
      enew
      normal! P
      setlocal buftype=nowrite
      set filetype=%s
      diffthis
      execute \"normal! \\<C-w>\\<C-w>\"
      enew
      set filetype=%s
      normal! \"xP
      diffthis"
      (string.format ftype ftype)
      vim.cmd)))

(vim.api.nvim_create_autocmd
  :TextYankPost
  {:group (vim.api.nvim_create_augroup :yank_highlight {})
   :pattern :*
   :callback 
   (fn [] (vim.highlight.on_yank {:higroup :IncSearch :timeout 300}))})

{}
