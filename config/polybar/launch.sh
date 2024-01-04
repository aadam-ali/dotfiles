#!/bin/bash

killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

non_primary_monitors=$(xrandr -q | grep -w 'connected' | grep -v 'primary' | cut -d' ' -f1)

polybar --config="$HOME/.config/polybar/config.ini" primary &

for m in $non_primary_monitors; do
  MONITOR=$m polybar --config="$HOME/.config/polybar/config.ini" secondary &
done

echo "Polybar launched..."
