#! /usr/bin/bash

sinks=$(pactl list sinks)

curr=$(pactl get-default-sink)

new_sink=$(python3 ~/.config/awesome/switch_sink.py "$curr" "$sinks")

echo "$new_sink"

pactl set-default-sink "$new_sink"
