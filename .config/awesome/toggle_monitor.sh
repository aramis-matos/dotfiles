#! /bin/bash

xrandrOn="xrandr --output HDMI-0 --rate 60.00 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-0 --off --output DP-1 --off --output DP-2 --rate 165.00 --primary --mode 2560x1440 --pos 1920x0 --rotate normal --output DP-3 --off --output DP-4 --off --output DP-5 --off"
xrandrOff="xrandr --output HDMI-0 --off --output DP-0 --off --output DP-1 --off --output DP-2 --rate 165.00 --primary --mode 2560x1440 --pos 1920x0 --rotate normal --output DP-3 --off --output DP-4 --off --output DP-5 --off"

while true; do
    apex=$(pidof R5Apex.exe)
    grepOut=$(xrandr --listactivemonitors | grep "HDMI-0")
    if [ "$apex" != "" ]; then
        exec $xrandrOff
    elif [ "$grepOut" == "" ]; then
        exec $xrandrOn
    fi

done