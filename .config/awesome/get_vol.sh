#! /usr/bin/bash

names=$(pactl list sinks | grep "Name: " | awk '{print $2}')
vols=$(pactl list sinks | grep "Volume: front-left: " | awk '{print $5}')
curr=$(pactl info | sed -En 's/Default Sink: (.*)/\1/p')

fish -c 'echo -ne \U1F39A' ; python3 ~/.config/awesome/get_vol.py "$curr" "$names" "$vols"


