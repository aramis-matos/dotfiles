{config,...}: 

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    settings = {
      "$mainMod" = "SUPER";
      monitor = [
        "DP-1, 3840x2160@160, 2560x0, 1.5"
        "DP-2, 2560x1440@144, 0x0, 1"
      ];

      "$terminal" = "kitty";
      "$fileManager" = "$terminal yazi";
      "$menu" = "fuzzel";

      env = [
        "XCURSOR_SIZE,32"
        "HYPRCURSOR_SIZE,24"
        "GDK_SCALE,2"
      ];

      general = {
        "gaps_in" = "5";
        "gaps_out" = "20";

        border_size = 2;

        # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        # Set to true enable resizing windows by clicking and dragging on borders and gaps
        "resize_on_border" = "false";

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        "allow_tearing" = "false";

        "layout" = "dwindle";
      };

      decoration = {
        "rounding" = "10";

        # Change transparency of focused and unfocused windows
        "active_opacity" = "1.0";
        "inactive_opacity" = "1.0";

        # drop_shadow = true
        # shadow_range = 4
        # shadow_render_power = 3
        # col.shadow = rgba(1a1a1aee)

        # https://wiki.hyprland.org/Configuring/Variables/#blur
        blur = {
          "enabled" = "true";
          "size" = "5";
          "passes" = "1";

          "vibrancy" = "0.1696";
        };
      };

      # https://wiki.hyprland.org/Configuring/Variables/#animations
      animations = {
        "enabled" = "true";

        # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        "bezier" = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];

        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
      };

      dwindle = {
        "pseudotile" = "true"; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        "preserve_split" = "true"; # You probably want this
      };

      # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
      master = {
        "new_status" = "master";
      };

      # https://wiki.hyprland.org/Configuring/Variables/#misc
      misc = {
        "force_default_wallpaper" = "-1"; # Set to 0 or 1 to disable the anime mascot wallpapers
        "disable_hyprland_logo" = "true"; # If true disables the random hyprland logo / anime girl background. :(
      };

      input = {
        "kb_layout" = "us";
        "kb_variant" = "";
        "kb_model" = "";
        "kb_options" = "";
        "kb_rules" = "";

        "follow_mouse" = "1";

        "sensitivity" = "0"; # -1.0 - 1.0, 0 means no modification.

        touchpad = {
          "natural_scroll" = "false";
        };
      };

      # gestures = {
      #   "workspace_swipe" = "false";
      # };

      # Example per-device config
      # See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
      device = {
        "name" = "epic-mouse-v1";
        "sensitivity" = "-0.5";
      };

      xwayland = {
        "force_zero_scaling" = "true";
      };

      bind = [

        # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
        "$mainMod, RETURN, exec, $terminal tmux new-session -A -s main"
        "$mainMod SHIFT, C, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating,"
        "$mainMod, R, exec, $menu"
        "$mainMod, P, pseudo," # dwindle
        "$mainMod, S, togglesplit," # dwindle

        # Move focus with mainMod + arrow keys
        "$mainMod, L, movefocus, l"
        "$mainMod, H, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        # Personal Binds
        "$mainMod SHIFT, F, fullscreen"
        "$mainMod, F, exec, zen"
        "$mainMod, C, exec, code --ozone-platform=wayland --enable-features=WaylandWindowDecorations"
        "$mainMod SHIFT, o, exec, systemctl poweroff"
        "$mainMod SHIFT, p, exec, systemctl reboot"
        "$mainMod SHIFT, BackSpace, exec, switch-sink"
        "$mainMod, BackSpace, exec, playerctl play-pause -a"
        "$mainMod SHIFT, S, exec, grimblast copy area"
        "ALT, Print, exec, grimblast copy screen"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      binde = [
        "$mainMod, equal, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
        "$mainMod, minus, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-"
      ];

      "windowrulev2" = "suppressevent maximize, class:.*"; # You'll probably like this.

      "exec-once" = [
        "fcitx5 -d &"
        "waytrogen -r -s 1000"
        "emacs --daemon -q -l ${config.home.file.emacs.source}"
      ];

      "exec" = [
        "gen-color-scheme"
      ];

    };
  };
}
