(local {: autoload} (require :nfnl.module))
(local {: tx : has : on-very-lazy} (autoload :config.util))

[(tx :folke/noice.nvim
    {:event :VeryLazy
     :opts {:lsp {:progress: {:view :notify}}
            :override {:vim.lsp.util.convert_input_to_markdown_lines true
                       :vim.lsp.util.stylize_markdown false
                       :cmp.entry.get_documentation false}
            :routes [{:filter {:event :msg_show} :opts {:skip true}}
                     {:filter {:event :msg_show :kind :wmsg} :opts {:skip true}}]
            :presets {:bottom_search false
                      :long_message_to_split true
                      :inc_rename false
                      :lsp_doc_border true}
            :cmdline_popup {:views {:row :50% :col :50%}}
                            :win_options {:winhighlight "NormalFloat:NormalFloat, FloatBorder:FloatBorder"}}
     :dependencies [:MunifTanjim/nui.nvim]})
 (tx :MunifTanjim/nui.nvim)
 (tx :rcarriga/nvim-notify
     {:opts {:background_colour :#1a1b26
             :level 3
             :render :compact
             :stages :static
             :timeout 3000
             :max_height (fn [] (math.floor (* vim.o.lines 0.75)))
             :max_width (fn [] (math.floor (* vim.o.columns 0.75)))}
      :init (fn []
              (when (not (has :noice.nvim))
                (on-very-lazy (fn [] (set vim.notify (require :notify))))))})]

