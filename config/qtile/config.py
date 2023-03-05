from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from utils import color

import os
import subprocess

from libqtile import hook

textColor = "#b2b2b2"


@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/scripts/autostart')
    subprocess.Popen([home])


mod = "mod4"
terminal = "kitty"

keys = [
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.spawn("rofi -show drun -theme ~/.config/bspwm/rices/z0mbi3/launcher.rasi")),
    Key([], "print", lazy.spawn("spectacle --region")),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "r", lazy.reload_config()),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
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
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "Tab", lazy.screen.next_group(), desc="Toggle between layouts"),
    Key([mod, "shift"], "Tab", lazy.screen.prev_group(), desc="Toggle between layouts"),
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

    Key([mod, "shift"], "Return", lazy.spawn("bash ~/.config/qtile/scripts/dmenuscript")),
]

groups = [Group(f"{i+1}", label="") for i in range(8)]

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
                    desc="Switch to & move focused window to group {}".format(i.name),
                    ),
                ]
            )

# layouts = [
#     layout.Columns(margin=8, border_focus=""),
#     layout.Max(),
#     # Try more layouts by unleashing below layouts.
#     # layout.Stack(num_stacks=2),
#     # layout.Bsp(),
#     # layout.Matrix(),
#     # layout.MonadTall(),
#     # layout.MonadWide(),
#     # layout.RatioTile(),
#     # layout.Tile(),
#     # layout.TreeTab(),
#     # layout.VerticalTile(),
#     # layout.Zoomy(),
# ]


# ---- Tiling ---------------------------- #
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
    change_ratio = 0.02,
    min_ratio = 0.30,
    max_ratio = 0.70,
  ),

  layout.Max(**config),
]

# ---- Floating -------------------------- #
floating_layout = layout.Floating(
  border_focus = color['white'],
  border_normal = color['bg'],
  border_width = 0,
  fullscreen_border_width = 0,

  float_rules = [
    *layout.Floating.default_float_rules,
    Match(wm_class = [
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
    ]), # type: ignore

    Match(title = [
      'branchdialog',
      'File Operation Progress',
      'minecraft-launcher',
      'Open File',
      'pinentry',
      'wm',
    ]), # type: ignore
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
        wallpaper = "~/.config/qtile/wallpapers/evening-sky.png",
        wallpaper_mode = "fill",
        top=bar.Bar(
            [
				widget.Spacer(length=20,
                    background='#000000',
                ),
				
                widget.GroupBox(
                    fontsize=16,
                    borderwidth=3,
                    highlight_method='text',
                    active=textColor,
                    highlight_color='#ffffff',
                    inactive="#818181",
                    foreground='#ffffff',
                    background='#000000',
                    this_current_screen_border='#ffffff',
                    this_screen_border='#ffffff',
                    other_current_screen_border='#ffffff',
                    other_screen_border='#ffffff',
                    urgent_border='#ffffff',
                    rounded=True,
                    disable_drag=True,
                 ),


                widget.Spacer(
                    # length=800,
                    background="#000000"
                ),

                # widget.CurrentLayoutIcon(
                #     background='#000000',
                #     font = "JetBrainsMono NF",
                #     foreground = textColor,
                #     padding = 0,
                #     scale = 0.5,
                # ),

                # widget.CurrentLayout(
                #     background='#000000',
                #     foreground=textColor,
                #     font='JetBrainsMono NF',
                # ),

                # widget.WindowName(
                #     background = '#000000',
                #     format = "{name}",
                #     font='JetBrainsMono NF',
                #     empty_group_string = '???',
                #     foreground=textColor
                # ),

                widget.Clock(
                    format = '%A - %H:%M ',
                    long_format = '%B %-d, %Y ',
                    # format=' %H:%M',
                    background='#000000',
                    foreground=textColor,
                    font="JetBrainsMono NF",
                    fontsize = 14
                ),

                widget.Spacer(),

                # sudo python3 -m pip install iwlib

                widget.TextBox(
                    foreground=textColor,
                    font="JetBrainsMono NF",
                    text="󰤨",
                    fontsize=24,
                ),

                widget.Wlan(
                    foreground=textColor,
                    font="JetBrainsMono NF",
                    format='{essid}',  # {quality}%
                    fontsize=14,
                    padding=2
                ),
                                
                widget.Battery(format=' {percent:2.0%}',
                    font="JetBrainsMono NF",
                    fontsize=14,
                    padding=10,
                    background='#000000',
                    foreground=textColor
                ),                     
                 
               
                widget.Memory(format='﬙{MemUsed: .0f}{mm}',
                    font="JetBrainsMono NF",
                    fontsize=14,
                    padding=10,
                    background='#000000',
                    foreground=textColor
                ),

                widget.TextBox(
                    text="",
                    font="Font Awesome 6 Free Solid",
                    fontsize=8,
                    padding=0,
                    foreground=textColor,
                    background='#000000',

                ),
                
                widget.PulseVolume(font='JetBrains Mono Bold',
                    fontsize=14,
                    padding=5,
                    background='#000000',
                    foreground=textColor
                ),                

                widget.CurrentLayoutIcon(
                    background='#000000',
                    font = "JetBrainsMono NF",
                    foreground = textColor,
                    padding = 0,
                    scale = 0.5,
                ),

                widget.CurrentLayout(
                    background='#000000',
                    fontsize=13.3,
                    padding=0,
                    foreground=textColor,
                    font='JetBrainsMono NF',
                ),

                widget.Spacer(
                    length=20,
                    background='#000000',
                ),
            ],
            30,

            margin=[6, 15, 6, 15],
        )
    ),
]

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

floating_layout = layout.Floating(
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True
wl_input_rules = None
wmname = "O_O"
