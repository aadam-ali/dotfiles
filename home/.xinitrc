#!/bin/sh

# Configure Monitors
xrandr \
  --output DisplayPort-0 --primary --mode 1920x1080 --pos 1080x420 --rotate normal --rate 144 \
  --output DisplayPort-1 --mode 1920x1080 --pos 0x0 --rotate left --rate 144

xrdb ~/.Xresources || true

exec i3
