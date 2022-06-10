#!/bin/bash
#
# low battery warning
#

# BATTERY=/sys/class/power_supply/BAT0
#
# REM=`grep "POWER_SUPPLY_CHARGE_NOW" $BATTERY/uevent | awk -F= '{ print $2 }'`
# FULL=`grep "POWER_SUPPLY_CHARGE_FULL_DESIGN" $BATTERY/uevent | awk -F= '{ print $2 }'`
# PERCENT=`echo $(( $REM * 100 / $FULL ))`
#
# if [ $PERCENT -le "82" ]; then
#     logger "low battery"
#   /usr/bin/notify-send -m "Low battery"
# else
#     logger "WE ALL GOOD!"
# fi
