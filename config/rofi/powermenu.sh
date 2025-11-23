#!/usr/bin/env bash

options="Lock\nLogout\nRestart\nShutdown\nSleep"
option=$(echo -e $options | rofi -p 'Power' -i -dmenu)

case "$option" in
  "Shutdown")
    systemctl poweroff
    ;;
  "Logout")
    swaymsg exit
    ;;
  "Restart")
    systemctl reboot
    ;;
  "Sleep")
    systemctl suspend
    ;;
  "Lock")
    swaylock
    ;;
esac
