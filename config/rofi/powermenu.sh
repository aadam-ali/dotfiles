#!/usr/bin/env bash

options="Lock\nLogout\nRestart\nShutdown\nSleep"
option=$(echo -e $options | rofi -dmenu)

case "$option" in
  "Shutdown")
    systemctl poweroff
    ;;
  "Logout")
    i3-msg exit
    ;;
  "Restart")
    systemctl reboot
    ;;
  "Sleep")
    systemctl suspend
    ;;
  "Lock")
    i3lock -n -c 1d1f21
    ;;
esac
