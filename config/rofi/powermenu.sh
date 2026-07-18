#!/usr/bin/env bash

options="\n󰒲\n󰍃\n\n"
option=$(echo -e $options | rofi -dmenu -theme "$HOME/.config/rofi/powermenu.rasi")

case "$option" in
  *"")
    systemctl poweroff
    ;;
  *"󰍃")
    swaymsg exit
    ;;
  *"")
    systemctl reboot
    ;;
  *"󰒲")
    systemctl suspend
    ;;
  *"")
    swaylock
    ;;
esac
