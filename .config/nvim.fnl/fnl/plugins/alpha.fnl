(local {: autoload} (require :nfnl.module))
(local {: tx : autocmd} (autoload :config.util))
(local {: icons} (autoload :config.constants))

[(tx :goolord/alpha-nvim
       {:event [:VimEnter :BufReadPost :BufNewFile]
        :lazy true
        :priority 1000
        :opts (fn []
                (let [logo "       _______             ____   ____.__
       \\      \\   ____  ___\\   \\ /   /|__| _____
       /   |   \\_/ __ \\/  _ \\   Y   / |  |/     \\
      /    |    \\  ___(  <_> )     /  |  |  Y Y  \\
      \\____|__  /\\____ >____/ \\___/   |__|__|_|  /
              \\/                               \\/
      "
      dashboard (require :alpha.themes.dashboard)]
                  (set dashboard.section.header.val (vim.split logo "\n" {}))
                  (set dashboard.section.buttons.val [(dashboard.button :f (.. icons.documents.Files " Find file") ":Telescope find_files <CR>")
                                                     (dashboard.button :r (.. icons.ui.History " Recent files") ":Telescope oldfiles <CR>")
                                                     (dashboard.button :t (.. icons.ui.List " Find text") ":Telescope live_grep <CR>")
                                                     (dashboard.button :c (.. icons.ui.Gear " Config") ":e ~/.config/nvim/init.fnl | cd ~/.config/nvim <CR>")
                                                     (dashboard.button :u (.. icons.ui.CloudDownload " Update") ":Lazy <CR>")
                                                     (dashboard.button :q (.. icons.ui.SignOut " Quit") ":qa<CR>")])
                  (each [_ button (ipairs dashboard.section.buttons.val)]
                    (set button.opts.hl :AlphaButtons)
                    (set button.opts.hl_shortcut :AlphaShortcut))
                  (set dashboard.section.header.opts.hl :AlphaHeader)
                  (set dashboard.section.buttons.opts.hl :AlphaButtons)
                  (set dashboard.section.footer.opts.hl :Type)
                  (set dashboard.opts.opts.noautocmd true)
                  dashboard))
        :config (fn [_ dashboard]
                  (when (= vim.o.filetype :lazy)
                    (vim.cmd.close)
                    (autocmd :User {:pattern :AlphaReady :callback (fn []
                                                                        ((. (require :lazy) :show)))}))
                  ((. (require :alpha) :setup) dashboard.opts)
                  (autocmd :User {:pattern :LazyVimStarted :callback (fn []
                                                                          (let [footerLogo "       ⣇⣿⠘⣿⣿⣿⡿⡿⣟⣟⢟⢟⢝⠵⡝⣿⡿⢂⣼⣿⣷⣌⠩⡫⡻⣝⠹⢿⣿⣷
       ⡆⣿⣆⠱⣝⡵⣝⢅⠙⣿⢕⢕⢕⢕⢝⣥⢒⠅⣿⣿⣿⡿⣳⣌⠪⡪⣡⢑⢝⣇
       ⡆⣿⣿⣦⠹⣳⣳⣕⢅⠈⢗⢕⢕⢕⢕⢕⢈⢆⠟⠋⠉⠁⠉⠉⠁⠈⠼⢐⢕⢽
       ⡗⢰⣶⣶⣦⣝⢝⢕⢕⠅⡆⢕⢕⢕⢕⢕⣴⠏⣠⡶⠛⡉⡉⡛⢶⣦⡀⠐⣕⢕
       ⡝⡄⢻⢟⣿⣿⣷⣕⣕⣅⣿⣔⣕⣵⣵⣿⣿⢠⣿⢠⣮⡈⣌⠨⠅⠹⣷⡀⢱⢕
       ⡝⡵⠟⠈⢀⣀⣀⡀⠉⢿⣿⣿⣿⣿⣿⣿⣿⣼⣿⢈⡋⠴⢿⡟⣡⡇⣿⡇⡀⢕
       ⡝⠁⣠⣾⠟⡉⡉⡉⠻⣦⣻⣿⣿⣿⣿⣿⣿⣿⣿⣧⠸⣿⣦⣥⣿⡇⡿⣰⢗⢄
       ⠁⢰⣿⡏⣴⣌⠈⣌⠡⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣬⣉⣉⣁⣄⢖⢕⢕⢕
       ⡀⢻⣿⡇⢙⠁⠴⢿⡟⣡⡆⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣵⣵⣿
       ⡻⣄⣻⣿⣌⠘⢿⣷⣥⣿⠇⣿⣿⣿⣿⣿⣿⠛⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
       ⣷⢄⠻⣿⣟⠿⠦⠍⠉⣡⣾⣿⣿⣿⣿⣿⣿⢸⣿⣦⠙⣿⣿⣿⣿⣿⣿⣿⣿⠟
       ⡕⡑⣑⣈⣻⢗⢟⢞⢝⣻⣿⣿⣿⣿⣿⣿⣿⠸⣿⠿⠃⣿⣿⣿⣿⣿⣿⡿⠁⣠
       ⡝⡵⡈⢟⢕⢕⢕⢕⣵⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣿⣿⣿⣿⣿⠿⠋⣀⣈⠙
       ⡝⡵⡕⡀⠑⠳⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⢉⡠⡲⡫⡪⡪⡣
          "                                                                                stats ((. (require :lazy) :stats))
                                                                                ms (/ (math.floor (+ (* stats.startuptime 100) 0.5)) 100)]
                                                                            (set dashboard.section.footer.val
                                                                                 (.. "⚡ Neovim loaded " stats.count " plugins in " ms :ms "\n" footerLogo))
                                                                            (pcall vim.cmd.AlphaRedraw)))}))})]
