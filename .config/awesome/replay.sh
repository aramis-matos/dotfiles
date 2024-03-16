#! /bin/bash

gpu-screen-recorder -w $(xdotool selectwindow) -c mp4 -f 60 -o ~/Downloads/$(date '+%m%d%y_%T_%N')_replay.mp4 -k 'h265' -a $(pactl get-default-sink).monitor  -q "very_high"
