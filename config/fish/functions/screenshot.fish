# only for hyprland!

function screenshot
  grim -g "$(slurp)" - | wl-copy
end
