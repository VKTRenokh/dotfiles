
#!/usr/bin/env bash

DMEDITOR="nvim"

declare -a options=(
"awesome - $HOME/.config/awesome/rc.lua"
"qtile - $HOME/.config/qtile/config.json"
"bspwm - $HOME/.config/bspwm/bspwmrc"
"neovim - $HOME/.config/nvim/init.lua"
"kitty - $HOME/.config/kitty/kitty.conf"
"picom - $HOME/.config/picom/picom.conf"
"qutebrowser - $HOME/.config/qutebrowser/config.py"
"xmobar - $HOME/.config/xmobar/doom-one-xmobarrc"
"xmonad - $HOME/.config/xmonad/xmonad.hs"
"zsh - $HOME/.zshrc"
)

choice=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i -theme ~/.config/qtile/rofi/launchers/misc/screen.rasi)

if [ "$choice" ]; then
  cfg=$(printf '%s\n' "${choice}" | awk '{print $NF}')
  "kitty" -d $(dirname $cfg) "-e" $DMEDITOR "$cfg"
  echo $(dirname $cfg)

else 
  echo "Program terminated." && exit 1
fi
