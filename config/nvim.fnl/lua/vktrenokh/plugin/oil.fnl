(local uu (require :vktrenokh.util))

(uu.tx
  :stevearc/oil.nvim
  { :keys [ 
          {1 :SF 2 "<cmd>lua require('oil').open_float()<cr>" :desc "Open floating oil" }
          {1 :Sf 2 :<cmd>Oil<cr> :desc "Open oil" }
         ]
  :opts {
        :default_file_explorer false
        :columns ["icon" "permissions"]
        :buf_options {:buflisted false}
        :keymaps {
        :g? "actions.show_help"
        :<CR> "actions.select"
        :<C-s> "actions.select_vsplit"
        :<C-h> "actions.select_split"
        :<C-t> "actions.select_tab"
        :<C-p> "actions.preview"
        :<Esc> "actions.close"
        :<C-l> "actions.refresh"
        "<leader>" "actions.parent"
        "`" "actions.cd"
        "~" "actions.tcd"
        :g. "actions.toggle_hidden"
        :q "actions.close"
        :_ "actions.open_cwd"
        }
        :float {:padding 5
        :max_width 0
        :max_height 0
        :border "rounded"
        :win_options {:winblend 10}
        :override (fn [conf] conf)
        }
        :win_options {
        :signcolumn :yes
        }
        :preview {
        :max_width 0.0
        :min_width [40 0.4]
        :width nil
        :mex_height 0.0
        :height nil
        :border :rounded
        :win_options {
         :winblend 0
        }}
        :view_options {:show_hidden true}}
        :prompt_save_on_select_new_entry false
        :config (fn [_ opts]
                  (let [oil (require :oil)]
                  (oil.setup opts)))
        })
