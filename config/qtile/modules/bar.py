from libqtile.lazy import lazy
from libqtile import bar
from string import Template
from qtile_extras import widget
from qtile_extras.widget.decorations import PowerLineDecoration
from qtile_extras.widget.decorations import RectDecoration
import os
from utils import color

def createBar(settings):
    textColor = settings['textColor']
    withDecorations = settings["decorated"]
    decoratedTextColor = textColor if not withDecorations else settings["decorations"]["decoratedTextColor"]

    def createDecorationGroup(color):
        decorations = {}

        if withDecorations:
            decorations = {
                "decorations": [
                    RectDecoration(colour=color, radius=settings['decorations']["round"], filled=True, padding_y=3, group=True)
                ],
                "padding": settings["decorations"]["padding"],
            }

        return decorations

    @lazy.function
    def openCalendar(qtile):
        qtile.cmd_spawn("kitty --title cal_term --hold cal")

    return bar.Bar(
            [
				widget.Spacer(length=20),
                widget.GroupBox(
                    fontsize=16,
                    borderwidth=3,
                    highlight_method='text',
                    active=textColor,
                    highlight_color='#ffffff',
                    inactive="#818181",
                    foreground='#ffffff',
                    this_current_screen_border='#ffffff',
                    this_screen_border='#ffffff',
                    other_current_screen_border='#ffffff',
                    other_screen_border='#ffffff',
                    urgent_border='#ffffff',
                    rounded=True,
                    disable_drag=True,
                 ),
                widget.Spacer(),
                widget.Clock(
                format = '%A - %H:%M',
                    long_format = '%B %-d, %Y ',
                    foreground=textColor,
                    font="JetBrainsMono NF",
                    fontsize = 14,
                    mouse_callbacks = {'Button1': openCalendar},
                ),
                widget.Spacer(),
                # sudo python3 -m pip install iwlib
                widget.Wlan(
                    font="JetBrainsMono NF",
                    format='󰤨 {essid}',  # {quality}%
                    fontsize=14,
                    foreground=decoratedTextColor,
                    **createDecorationGroup(color['magenta'])
                ),
                widget.Spacer(length=10),
                widget.Battery(
                    format=' {percent:2.0%}',
                    font="JetBrainsMono NF",
                    fontsize=14,
                    foreground=decoratedTextColor,
                    **createDecorationGroup(color['blue'])
                ),                     
                widget.Spacer(length=10),
                widget.Memory(format='﬙{MemUsed: .0f}{mm}',
                    font="JetBrainsMono NF",
                    fontsize=14,
                    foreground=decoratedTextColor,
                    **createDecorationGroup(color["cyan"])
                ),
                widget.Spacer(length=10),
                widget.PulseVolume(
                    font='JetBrainsMono NF',
                    fontsize=14,
                    foreground=decoratedTextColor,
                    fmt=" {}",
                    **createDecorationGroup(color["green"])
                ),                
                widget.Spacer(length=10),
                widget.CurrentLayout(
                    fontsize=13.3,
                    foreground=decoratedTextColor,
                    font='JetBrainsMono NF',
                    **createDecorationGroup(color["yellow"])
                ),
                widget.Spacer(length = 10),
                widget.TextBox(
                    foreground = decoratedTextColor,
                    font = "JetBrainsMono NF",
                    fontsize = 30,
                    text = "󰤆",
                    mouse_callbacks = {'Button1': lazy.spawn(["sh", os.path.expanduser("~/.config/qtile/rofi/bin/powermenu")])},
                    **createDecorationGroup(color["red"]),
                ),
                widget.Spacer(
                    length=20,
                ),
            ],
            settings['height'] or 30,

            margin=[6, 15, 6, 15],
        )

