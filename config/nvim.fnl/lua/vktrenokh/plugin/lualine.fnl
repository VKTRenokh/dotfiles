(local uu (require :vktrenokh.util))

(fn hide_in_width []
  (> (vim.fn.winwidth 0) 80))

(fn fg [name]
  (fn []
    (let [hl (vim.api.nvim_get_hl_by_name name true)]
      (and (and hl hl.foreground) {:fg (string.format "#%06x" hl.foreground)}))))

(fn progress []
  (let [current_line (vim.fn.line :.)
        total_lines (vim.fn.line :$)
        chars [ :▁▁ :▂▂ :▃▃ :▄▄ :▅▅ :▆▆ :▇▇ :██ ]
        line_ratio (/ current_line total_lines)
        index (math.ceil (* line_ratio (length chars)))]
        (. chars index)))

(fn spaces []
  (.. :spaces: (vim.api.nvim_buf_get_option 0 :shiftwidth)))

(local disabled [:dashboard :lazy :NvimTree :Outline :alpha])

(uu.tx
  :nvim-lualine/lualine.nvim
  {:event "VeryLazy"
  :opts {:options {:section_separators {:left "" :right ""}
         :icons_enabled true
         :component_separators { :left : :right :}}
         :disable_filetypes disabled
         :ignore_focus []
         :always_divide_middle true
         :globalstatus true
         :refresh {:statusline 1000 :tabline 1000 :winbar 1000}
  :sections {
  :lualine_a [{1 :mode :fmt (fn [str] 
                              (string.lower str))}]
  :lualine_b [{1 :branch :icons_enabled true :icon :}]
  :lualine_c [{1 :filename :file_status true :path 1}]
  :lualine_y [[ progress ]]
  :lualine_z [{1 :location :padding 0}]
  }}})
