#!/usr/bin/env sh

# Add this script to your wm startup file.

DIR="$HOME/.config/polybar/theos"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
#while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar
polybar --reload -q workspaces -c "$DIR"/config.ini 
polybar --reload -q sysinfo -c "$DIR"/config.ini
polybar --reload -q org-timer-bar -c "$DIR"/config.ini

xdo raise -N Polybar

