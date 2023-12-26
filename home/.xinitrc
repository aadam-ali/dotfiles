#!/bin/sh

# Configure Monitors
xrandr --output DisplayPort-0 --mode 1920x1080 --rate 144
xrandr --output DisplayPort-1 --mode 1920x1080 --rate 144
xrandr --output DisplayPort-1 --rotate left
xrandr --output DisplayPort-1 --left-of DisplayPort-0

exec i3
