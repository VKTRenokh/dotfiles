from libqtile import layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from utils import color
from utils import dir
from utils.settings import config as settings
from modules import bar, binds
import os
import subprocess
from libqtile import hook

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/scripts/autostart')
    subprocess.Popen([home])


keys = binds.createBinds('mod4')

groups = [Group(i, label="") for i in "123456789"]

mod = 'mod4'

for i in groups:
    keys.extend(
        [
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(
                    i.name),
            ),
        ]
    )

config = {
    'border_focus': color['magenta'],
    'border_normal': color['bg'],
    'border_width': 0,
    'margin': 10,
    'single_border_width': 0,
    'single_margin': 10,
}

layouts = [
    layout.MonadTall(
        **config,
        change_ratio=0.02,
        min_ratio=0.30,
        max_ratio=0.70,
    ),

    layout.Max(**config),

    layout.Spiral(),


    layout.Matrix(),

    layout.MonadWide(),

    layout.Zoomy(),

    layout.Columns(margin=8, border_focus=""),

    layout.RatioTile(),
]

floating_layout = layout.Floating(
    border_focus=color['blue'],
    border_normal=color['bg'],
    border_width=0,
    fullscreen_border_width=0,

    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class=[
            'confirmreset',
            'gnome-screenshot',
            'lxappearance',
            'makebranch',
            'maketag',
            'psterm',
            'ssh-askpass',
            'thunar',
            'Xephyr',
            'xfce4-about',
            'wm',
        ]),  # type: ignore

        Match(title=[
            'branchdialog',
            'File Operation Progress',
            'minecraft-launcher',
            'Open File',
            'pinentry',
            'wm',
            "cal_term"
        ]),  # type: ignore

        # Match(title = "cal_term")
    ],
)

widget_defaults = dict(
    font="sans",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        wallpaper=settings['wallpaper'],
        wallpaper_mode=settings['wallpaperMode'],
        top=bar.createBar(settings['bar'])
    ),
]

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True
wl_input_rules = None

wmname = "HelloWorld wm"
