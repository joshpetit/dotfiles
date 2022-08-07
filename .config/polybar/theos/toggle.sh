#polybar-msg cmd toggle 

# Probably will be important
 #xprop _NET_WM_PID | sed 's/_NET_WM_PID(CARDINAL) = //'
all_visible=$(xdotool search --onlyvisible --name polybar-sysinfo)

org_bar=$(xdotool search --name polybar-org-timer getwindowpid)
workspaces_bar=$(xdotool search --name polybar-workspaces getwindowpid)
sysinfo_bar=$(xdotool search --name polybar-sysinfo getwindowpid)

polybar-msg -p "$workspaces_bar" cmd toggle
polybar-msg -p "$sysinfo_bar" cmd toggle

org_active=$(emacsclient --eval "(org-clock-is-active)")
active_clock_exit_code=$?
toggle_to="hide"

if [ "$all_visible" = "" ]
then
    toggle_to="show"
fi

if [  "$org_active" = "nil" ] | [ $active_clock_exit_code = 1 ]
then
    polybar-msg -p "$org_bar" cmd hide
else
    polybar-msg -p "$org_bar" cmd $toggle_to
fi



xdo raise -N Polybar
