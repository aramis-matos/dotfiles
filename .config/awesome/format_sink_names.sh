 python3 ~/.config/awesome/format_sink_names.py "$(pactl info | sed -En 's/Default Sink: (.*)/\1/p')" "$(pactl list sinks)"
