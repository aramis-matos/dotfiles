#!/usr/bin/env nix-shell
#! nix-shell -i bash
#! nix-shell --packages python3 pulseaudio

sinks=$(pactl list sinks)

curr=$(pactl get-default-sink)

new_sink=$(python3 ~/.config/awesome/switch_sink.py "$curr" "$sinks")

echo "$new_sink"

pactl set-default-sink "$new_sink"
