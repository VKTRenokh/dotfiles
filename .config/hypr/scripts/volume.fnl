(local base-dunstify-command "dunstify -u low -h string:x-dunst-stack-tag:obvolume -h int:value:")

(fn exec [executable]
  (let [handle (io.popen executable)
        result (: handle :read :*a)]
    (: handle :close)
    result))

(fn wp-ctl [args]
  (exec (.. "wpctl" " " args)))

(fn format-volume-percent [volume]
  (: (: volume :gsub "0?%." "") :gsub "Volume: " ""))

(fn remove-newlines [string]
  (: string :gsub "\n" ""))

(fn format-volume [volume]
  (.. " 'Volume: " volume "%'"))

(fn get-volume []
  (wp-ctl (.. "get-volume" " " "@DEFAULT_SINK@")))

(fn notify []
  (let [readable (format-volume-percent (remove-newlines (get-volume)))]
    (exec 
      (.. base-dunstify-command readable
          (format-volume readable)))))

(fn update-volume [amount]
  (wp-ctl (.. "set-volume" " " "@DEFAULT_SINK@" " " amount))
  (notify))

(local actions {:incr (fn []
                        (update-volume "5%+"))
                :decr (fn []
                        (update-volume "5%-"))})

((. actions (. arg 1)))
