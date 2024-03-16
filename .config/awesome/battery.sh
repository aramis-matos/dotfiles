#! /usr/bin/fish

echo -ne  \U1F50B ; upower -i /org/freedesktop/UPower/devices/battery_CMB0 | awk '/percentage/ {print $NF}'