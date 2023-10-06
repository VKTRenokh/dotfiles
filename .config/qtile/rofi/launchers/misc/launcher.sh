#!/usr/bin/env bash

## Author  : Aditya Shakya
theme="screen"
dir="$HOME/.config/qtile/rofi/launchers/misc"

rofi -no-lazy-grab -show drun -modi drun -theme $dir/"$theme"
