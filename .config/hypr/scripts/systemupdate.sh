#!/usr/bin/env bash

if [ ! -f /etc/arch-release ] ; then
    exit 0
fi

aur=$(paru -Qua | wc -l)
ofc=$(pacman -Qu | wc -l)

upd=$(( ofc + aur ))
echo "$upd"

if [ $upd -eq 0 ] ; then
    echo " Packages are up to date"
else
    echo " $ofc Official 󱓾 $aur AUR "
fi

if [ "$1" == "up" ] ; then
    kitty --title systemupdate sh -c 'yay -Syu'
fi
