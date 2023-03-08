from libqtile.lazy import lazy
from libqtile import bar, widget
from string import Template
import os

def createBar(textColor, terminal):

    @lazy.function
    def openCalendar(qtile):
        cmd = Template("$terminal --hold cal").substitute({"terminal": terminal})
        print(cmd)
        qtile.cmd_spawn(cmd)

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
                    format = '%A - %H:%M ',
                    long_format = '%B %-d, %Y ',
                    # format=' %H:%M',
                    foreground=textColor,
                    font="JetBrainsMono NF",
                    fontsize = 14,
                    mouse_callbacks = {'Button1': openCalendar},
                ),

                widget.Spacer(),

                widget.TextBox(
                    foreground=textColor,
                    font="JetBrainsMono NF",
                    text="󰤨",
                    fontsize=24,
                ),

                # sudo python3 -m pip install iwlib

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
                    foreground=textColor
                ),                     
                 
               
                widget.Memory(format='﬙{MemUsed: .0f}{mm}',
                    font="JetBrainsMono NF",
                    fontsize=14,
                    padding=10,
                    foreground=textColor
                ),

                widget.TextBox(
                    text="",
                    font="Font Awesome 6 Free Solid",
                    fontsize=8,
                    padding=0,
                    foreground=textColor,
                ),
                
                widget.PulseVolume(font='JetBrains Mono Bold',
                    fontsize=14,
                    padding=5,
                    foreground=textColor
                ),                

                widget.CurrentLayoutIcon(
                    font = "JetBrainsMono NF",
                    foreground = textColor,
                    padding = 0,
                    scale = 0.5,
                ),

                widget.CurrentLayout(
                    fontsize=13.3,
                    padding=0,
                    foreground=textColor,
                    font='JetBrainsMono NF',
                ),

                widget.TextBox(
                    foreground = textColor,
                    font = "JetBrainsMono NF",
                    fontsize = 30,
                    text = "󰤆",
                    mouse_callbacks = {'Button1': lazy.spawn(["sh", os.path.expanduser("~/.config/qtile/rofi/bin/powermenu")])},
                ),

                widget.Spacer(
                    length=20,
                ),
            ],
            30,

            margin=[6, 15, 6, 15],
        )

