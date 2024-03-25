#!/usr/bin/env nix-shell
#! nix-shell -i fish
#! nix-shell --packages python3

set names (pactl list sinks | grep "Name: " | awk '{print $2}')
set vols (pactl list sinks | grep "Volume: front-left: " | awk '{print $5}')
set curr (pactl get-default-sink)

python3 ~/.config/awesome/get_vol.py "$curr" "$names" "$vols"
