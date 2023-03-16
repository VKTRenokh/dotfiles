from libqtile.config import Key
from libqtile.lazy import lazy
import subprocess
import os
import random
from libqtile.log_utils import logger
from utils.settings import settings

@lazy.function
def randomWall(qtile):
    path = os.path.expanduser("~/.config/qtile/wallpapers/")
    ls = os.listdir(path)
    wall = ls[random.randint(0, len(ls) - 1)]
    qtile.cmd_spawn(f'feh --bg-fill {path + wall}')

def createBinds(mod): 
    return [
        Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
        Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
        Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
        Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
        Key([mod, "shift"], "v", lazy.spawn("pavucontrol")),
        Key([mod], "space", lazy.spawn("rofi -show drun -theme ~/.config/bspwm/rices/z0mbi3/launcher.rasi")),
        Key([mod], "e", lazy.spawn(["sh", os.path.expanduser('~/.config/qtile/scripts/nvimlauncher.sh')])),
        Key([mod], "p", lazy.spawn(["sh", os.path.expanduser('~/.config/qtile/rofi/bin/powermenu')])),
        Key([mod], "u", lazy.hide_show_bar("top")),
        Key([], "print", lazy.spawn("spectacle -r -b -c")),
        Key([mod], "print", lazy.spawn("spectacle -r -c")),
        # Key([], "print", lazy.spawn("scrot -e 'xclip -selection clipboard -t image/png -i $f' -s")),
        Key([mod], "w", randomWall()),
        Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
        Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
        Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
        Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
        Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
        Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
        Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
        Key([mod, "control"], "r", lazy.reload_config()),
        Key([mod, "shift"], "c", lazy.restart()),
        Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
        Key([mod, "shift"], "w", lazy.spawn("qutebrowser")),
        Key([mod, "shift"], "d", lazy.spawn("discord")),
        Key([mod], "escape", lazy.layout.normalize(), desc="Reset all window sizes"),
        Key(
            [mod, "shift"],
            "Return",
            lazy.layout.toggle_split(),
            desc="Toggle between split and unsplit sides of stack",
        ),
        Key([mod], "f",
            lazy.window.toggle_fullscreen(),
            desc="Toggle fullscreen",
        ),
        Key([mod], "Return", lazy.spawn("kitty"), desc="Launch terminal"),
        Key([mod], "Tab", lazy.screen.next_group(skip_empty=True), desc="Toggle between layouts"),
        Key([mod, "shift"], "Tab", lazy.screen.prev_group(skip_empty=True), desc="Toggle between layouts"),
        Key([mod], "n", lazy.screen.next_group(), desc="Toggle between layouts"),
        Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
        Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
        Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
        Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
        Key(
            [], "XF86AudioRaiseVolume",
            lazy.spawn("amixer set Master 5%+")
        ),
        Key(
            [], "XF86AudioLowerVolume",
            lazy.spawn("amixer set Master 5%-")
        ),
        Key(
            [], "XF86AudioMute",
            lazy.spawn("amixer set Master toggle")
        ),
        Key(
            [mod],
            'backspace',
            lazy.next_layout()
        ),
        Key(
            [mod, "shift"],
            'backspace',
            lazy.prev_layout()
        ),
    
        Key([mod, "shift"], "Return", lazy.spawn("bash ~/.config/qtile/scripts/dmenuscript")),

        Key([], "XF86MonBrightnessUp", lazy.spawn("xbacklight -inc 10")),
        Key([], "XF86MonBrightnessDown", lazy.spawn("xbacklight -dec 10")),
    ]
