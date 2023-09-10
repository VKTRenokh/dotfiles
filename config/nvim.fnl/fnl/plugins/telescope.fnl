(local {: autoload} (require :nfnl.module))
(local {: tx} (autoload :config.util))
(local {: icons} (autoload :config.constants))

[(tx :nvim-telescope/telescope.nvim
    {:cmd :Telescope
     :keys [ {1 ";f" 2 "<cmd> lua require('telescope.builtin').find_files({ hidden = true}) <CR>"}
             {1 ";g" 2 "<cmd> lua require('telescope.builtin').git_commits() <cr>"}
             {1 ";r" 2 "<cmd> lua require('telescope.builtin').live_grep() <cr>"}
             {1 "\\\\" 2 "<cmd> lua require('telescope.builtin').buffers() <cr>"}
             {1 ";t" 2 "<cmd> lua require('telescope.builtin').help_tags() <cr>"}
             {1 ";;" 2 "<cmd> lua require('telescope.builtin').resume() <cr>"}
             {1 ";e" 2 "<cmd> lua require('telescope.builtin').diagnostics() <cr>"}
             {1 ";b" 2 "<cmd> lua require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({ winblend = 10, previewer = false}))<cr>"}
             {1 :sf 2 "<cmd> lua require('telescope').extensions.file_browser.file_browser({ path = '%:p:h', cwd = vim.fn.expand('%:p:h'), respect_gitignore = false, hidden = true, grouped = true, previewer = false, initial_mode = 'normal', layout_config = { prompt_position = 'top', height = 50}, layout_strategy = 'horizontal'}) <cr>"}]
     :version false
     :dependencies ["nvim-lua/plenary.nvim"
                    "nvim-telescope/telescope-file-browser.nvim"]
     :opts {:defaults {:layout_config {:prompt_position :top}
                       :layout_strategy :horizontal
                       :prompt_prefix icons.ui.Telescope
                       :sorting_strategy :ascending
                       :winblend 10}
            :pickers {:colorscheme {:enable_preview true}}}
     :config (fn [_ opts]
               ((. (require :telescope) :setup) opts))})
 (tx :nvim-telescope/telescope-file-browser.nvim
     {:dependencies [:nvim-telescope/telescope.nvim]
      :config (fn [] 
                (let [telescope (autoload :telescope)
                      fb_actions (. (. (. telescope :extensions) :file_browser) :actions)]
                (telescope.setup {:extensions {:file_browser {:theme :dropdown}
                                               :hijack_netrw true
                                               :mappings {:i {:<C-w> (fn []
                                                                        (vim.cmd "normal vbd"))}
                                                          :n {:N fb_actions.create
                                                              :h fb_actions.goto_parent_dir
                                                              :/ (fn []
                                                                   (vim.cmd :startinsert))}}}})
                (telescope.load_extension :file_browser)))})]
