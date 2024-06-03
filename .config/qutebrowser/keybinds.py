def bind(config):
    config.bind("<Tab>", ":tab-next")
    config.bind("<Shift-Tab>", ":tab-prev")
    config.bind(
        'M', 'hint links spawn mpv --cache=no -ytdl-format="bv[ext=mp4]+ba/b" {hint-url}')
    config.bind('Y', 'hint links spawn wl-copy {hint-url}')
    config.bind('te', 'open -t')
