from libqtile.lazy import lazy

@lazy.function
def randomWall(qtile):
    path = os.path.expanduser("~/.config/qtile/wallpapers/")
    ls = os.listdir(path)
    wall = ls[random.randint(0, len(ls) - 1)]
    qtile.cmd_spawn(f'feh --bg-fill {path + wall}')
