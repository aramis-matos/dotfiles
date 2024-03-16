#! /usr/bin/fish
python3 ~/.config/awesome/format_sink_names.py (pactl get-default-sink) (pactl list sinks)
