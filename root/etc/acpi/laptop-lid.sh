#!/bin/sh
grep -q closed /proc/acpi/button/lid/LID/state
source /home/joshu/.Xdbus
if [ $? == 0 ]
then
    # close action
    current=$(su -c 'DISPLAY=:0.0 autorandr --current' joshu)
    if [ "$current" == "laptop" ]
    then
        echo "CLOSED LAPTOP WITH ONE MONITOR"
        systemctl suspend
    fi
fi
