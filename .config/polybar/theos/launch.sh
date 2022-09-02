#!/usr/bin/env sh

# Add this script to your wm startup file.

DIR="$HOME/.config/polybar/theos"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
#while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar
polybar --reload -q workspaces -c "$DIR"/config.ini  & disown
polybar --reload -q sysinfo -c "$DIR"/config.ini & disown
polybar --reload -q org-timer-bar -c "$DIR"/config.ini & disown
polybar --reload -q music-bar -c "$DIR"/config.ini & disown
xdo raise -N Polybar

polybar-msg cmd hide
