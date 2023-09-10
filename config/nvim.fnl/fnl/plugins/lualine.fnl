(local {: autoload} (require :nfnl.module))
(local uu (autoload :config.util))
(local {: icons} (autoload :config.constants))
(local {: concat} (autoload :nfnl.string))

(fn hide_in_width []
  (> (vim.fn.winwidth 0) 80))

(fn fg [name]
  (fn []
    (let [hl (vim.api.nvim_get_hl_by_name name true)]
      (and (and hl hl.foreground) {:fg (string.format "#%06x" hl.foreground)}))))

(fn spaces [] 
  (concat "spaces " (vim.api.nvim_buf_get_option 0 :shiftwidth)))

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
  :lualine_x [{1 (fn [] 
                   ((. (. (. (. (autoload :noice) :api) :status) :command) :get)))
                 :cond (fn [] 
                         (and (. package.loaded :noice) ((. (. (. (. (autoload :noice) :api) :status)
                                      :command) :has))))
                 :color (fg :Statement)}
                 {1 (fn [] 
                   ((. (. (. (. (autoload :noice) :api) :status) :mode) :get)))
                 :cond (fn [] 
                         (and (. package.loaded :noice) ((. (. (. (. (autoload :noice) :api) :status)
                                      :mode) :has))))
                 :color (fg :Constant)}
                 {1 :diagnostics
                  :sources [:nvim_diagnostic]
                  :sections [:error :warn]
                  :symbols {:error icons.diagnostics.Error
                            :warn icons.diagnostics.Warning
                            :info icons.diagnostics.Information
                            :hint icons.diagnostics.Hint}
                  :colored true
                  :update_in_insert false
                  :always_visible true
                 }
                 {1 :diff
                 :colored false
                 :symbols {:added icons.git.Add :modified icons.git.Mod :removed icons.git.Remove}
                 :cond hide_in_width}
                 spaces
                 :encoding
                 {1 :filetype
                  :icons_enabled true
                  :icon nil
                  :colored true}]
  :lualine_y [[ progress ]]
  :lualine_z [{1 :location :padding 0}]}
  :inactive_sections {:lualine_a []
                      :lualine_b []
                      :lualine_c [{1 :filename :file_status true :path 1}]
                      :lualine_x [:location]
                      :lualine_y []
                      :lualine_z []}
 :tabline []
 :winbar []
 :inactive_winbar []
 :extensions [:fugitive]}})
