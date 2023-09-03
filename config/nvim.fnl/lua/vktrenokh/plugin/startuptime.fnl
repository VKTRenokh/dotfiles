(local uu (require :vktrenokh.util))

(uu.tx :dstein64/vim-startuptime
       {:cmd :StartupTime
        :init (fn []
                (uu.g :startuptime_tries 10))})
