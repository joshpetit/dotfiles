#!/bin/sh
source /home/joshu/.Xdbus
current=$(su -c 'DISPLAY=:0.0 autorandr --current' joshu)
grep -q closed /proc/acpi/button/lid/LID/state
# It is closed
if [ $? == 0 ]
then
    # close action
    if [ "$current" == "laptop" ]
    then
        echo "CLOSED LAPTOP WITH NO MONITORS"
        systemctl suspend
    fi
    if [ "$current" == "swift-normal" ]
    then
        echo "OPEND LAPTOP WITH MONITORS"
        #su -c 'DISPLAY=:0.0 autorandr --load monitors-only' joshu
    fi
else
    if [ "$current" == "monitors-only" ]
    then
        echo "OPENED LAPTOP WITH MONITORS"
        #su -c 'DISPLAY=:0.0 autorandr --load swift-normal' joshu
    fi
fi
