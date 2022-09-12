#polybar-msg cmd toggle 

# Probably will be important
 #xprop _NET_WM_PID | sed 's/_NET_WM_PID(CARDINAL) = //'
all_visible=$(xdotool search --onlyvisible --name polybar-sysinfo)

org_bar=$(xdotool search --name polybar-org-timer getwindowpid)
workspaces_bar=$(xdotool search --name polybar-workspaces getwindowpid)
sysinfo_bar=$(xdotool search --name polybar-sysinfo getwindowpid)
music_bar=$(xdotool search --name polybar-music-bar getwindowpid)


org_active=$(emacsclient --eval "(org-clock-is-active)")
active_clock_exit_code=$?
toggle_to="hide"
num_bottom_visible=0

if [ "$all_visible" = "" ] || [ $1 = "--show-all" ]
then
    toggle_to="show"
fi

polybar-msg -p "$workspaces_bar" cmd $toggle_to
polybar-msg -p "$sysinfo_bar" cmd $toggle_to

if [  "$org_active" != "nil" ] && [ $active_clock_exit_code != 1 ] ||  [ $1 = "--show-all" ]
then
    polybar-msg -p "$org_bar" cmd $toggle_to
    num_bottom_visible=$((num_bottom_visible+1))
else
    polybar-msg -p "$org_bar" cmd hide
fi

music_playing=$(playerctl metadata 2>&1)
if [[ "$music_playing" != "No player"* ]] || [ $1 = "--show-all" ]
then
    polybar-msg -p "$music_bar" cmd $toggle_to
    xdotool search --name "polybar-music-bar" windowmove --relative 0 $((-75 * num_bottom_visible))
else
    polybar-msg -p "$music_bar" cmd hide
fi


xdo raise -N Polybar
