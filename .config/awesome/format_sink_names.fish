#!/usr/bin/env nix-shell
#! nix-shell -i fish
#! nix-shell --packages python3 pulseaudio
python3 ~/.config/awesome/format_sink_names.py (pactl get-default-sink) (pactl list sinks)
