let
  username = "ccyanide";
in
{
  config,
  pkgs,
  inputs,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = username;
  home.homeDirectory = "/home/" + username;

  imports = [
    ./home/hyperland/hypr.nix
  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    texlive.combined.scheme-full
    jdk
    nil
    imagemagick
    poppler-utils
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    Downloads.source = config.lib.file.mkOutOfStoreSymlink (
      config.home.homeDirectory + "/mass_storage/Downloads"
    );
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/ccyanide/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # wayland.windowManager.hyprland = {
  #   enable = true;
  #   settings = {
  #     "$mainMod" = "SUPER";
  #     monitor = [
  #       "DP-1, 3840x2160@160, 2560x0, 1.5"
  #       "DP-2, 2560x1440@144, 0x0, 1"
  #     ];

  #     "$terminal" = "kitty";
  #     "$fileManager" = "$terminal yazi";
  #     "$menu" = "fuzzel";

  #     env = [
  #       "XCURSOR_SIZE,32"
  #       "HYPRCURSOR_SIZE,24"
  #       "GDK_SCALE,2"
  #     ];

  #     general = {
  #       "gaps_in" = "5";
  #       "gaps_out" = "20";

  #       border_size = 2;

  #       # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
  #       "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
  #       "col.inactive_border" = "rgba(595959aa)";

  #       # Set to true enable resizing windows by clicking and dragging on borders and gaps
  #       "resize_on_border" = "false";

  #       # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
  #       "allow_tearing" = "false";

  #       "layout" = "dwindle";
  #     };

  #     decoration = {
  #       "rounding" = "10";

  #       # Change transparency of focused and unfocused windows
  #       "active_opacity" = "1.0";
  #       "inactive_opacity" = "1.0";

  #       # drop_shadow = true
  #       # shadow_range = 4
  #       # shadow_render_power = 3
  #       # col.shadow = rgba(1a1a1aee)

  #       # https://wiki.hyprland.org/Configuring/Variables/#blur
  #       blur = {
  #         "enabled" = "true";
  #         "size" = "5";
  #         "passes" = "1";

  #         "vibrancy" = "0.1696";
  #       };
  #     };

  #     # https://wiki.hyprland.org/Configuring/Variables/#animations
  #     animations = {
  #       "enabled" = "true";

  #       # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

  #       "bezier" = "myBezier, 0.05, 0.9, 0.1, 1.05";

  #       animation = [
  #         "windows, 1, 7, myBezier"
  #         "windowsOut, 1, 7, default, popin 80%"
  #         "border, 1, 10, default"
  #         "borderangle, 1, 8, default"
  #         "fade, 1, 7, default"
  #         "workspaces, 1, 6, default"
  #       ];

  #       # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
  #     };

  #     dwindle = {
  #       "pseudotile" = "true"; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
  #       "preserve_split" = "true"; # You probably want this
  #     };

  #     # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
  #     master = {
  #       "new_status" = "master";
  #     };

  #     # https://wiki.hyprland.org/Configuring/Variables/#misc
  #     misc = {
  #       "force_default_wallpaper" = "-1"; # Set to 0 or 1 to disable the anime mascot wallpapers
  #       "disable_hyprland_logo" = "true"; # If true disables the random hyprland logo / anime girl background. :(
  #     };

  #     input = {
  #       "kb_layout" = "us";
  #       "kb_variant" = "";
  #       "kb_model" = "";
  #       "kb_options" = "";
  #       "kb_rules" = "";

  #       "follow_mouse" = "1";

  #       "sensitivity" = "0"; # -1.0 - 1.0, 0 means no modification.

  #       touchpad = {
  #         "natural_scroll" = "false";
  #       };
  #     };

  #     gestures = {
  #       "workspace_swipe" = "false";
  #     };

  #     # Example per-device config
  #     # See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
  #     device = {
  #       "name" = "epic-mouse-v1";
  #       "sensitivity" = "-0.5";
  #     };

  #     xwayland = {
  #       "force_zero_scaling" = "true";
  #     };

  #     bind = [

  #       # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
  #       "$mainMod, RETURN, exec, $terminal tmux new-session -A -s main"
  #       "$mainMod SHIFT, C, killactive,"
  #       "$mainMod, M, exit,"
  #       "$mainMod, E, exec, $fileManager"
  #       "$mainMod, V, togglefloating,"
  #       "$mainMod, R, exec, $menu"
  #       "$mainMod, P, pseudo," # dwindle
  #       "$mainMod, S, togglesplit," # dwindle

  #       # Move focus with mainMod + arrow keys
  #       "$mainMod, L, movefocus, l"
  #       "$mainMod, H, movefocus, r"
  #       "$mainMod, K, movefocus, u"
  #       "$mainMod, J, movefocus, d"

  #       # Switch workspaces with mainMod + [0-9]
  #       "$mainMod, 1, workspace, 1"
  #       "$mainMod, 2, workspace, 2"
  #       "$mainMod, 3, workspace, 3"
  #       "$mainMod, 4, workspace, 4"
  #       "$mainMod, 5, workspace, 5"
  #       "$mainMod, 6, workspace, 6"
  #       "$mainMod, 7, workspace, 7"
  #       "$mainMod, 8, workspace, 8"
  #       "$mainMod, 9, workspace, 9"
  #       "$mainMod, 0, workspace, 10"

  #       # Move active window to a workspace with mainMod + SHIFT + [0-9]
  #       "$mainMod SHIFT, 1, movetoworkspace, 1"
  #       "$mainMod SHIFT, 2, movetoworkspace, 2"
  #       "$mainMod SHIFT, 3, movetoworkspace, 3"
  #       "$mainMod SHIFT, 4, movetoworkspace, 4"
  #       "$mainMod SHIFT, 5, movetoworkspace, 5"
  #       "$mainMod SHIFT, 6, movetoworkspace, 6"
  #       "$mainMod SHIFT, 7, movetoworkspace, 7"
  #       "$mainMod SHIFT, 8, movetoworkspace, 8"
  #       "$mainMod SHIFT, 9, movetoworkspace, 9"
  #       "$mainMod SHIFT, 0, movetoworkspace, 10"

  #       # Scroll through existing workspaces with mainMod + scroll
  #       "$mainMod, mouse_down, workspace, e+1"
  #       "$mainMod, mouse_up, workspace, e-1"

  #       # Personal Binds
  #       "$mainMod SHIFT, F, fullscreen"
  #       "$mainMod, F, exec, librewolf"
  #       "$mainMod, C, exec, code --ozone-platform=wayland --enable-features=WaylandWindowDecorations"
  #       "$mainMod SHIFT, o, exec, shutdown now"
  #       "$mainMod SHIFT, p, exec, reboot"
  #       "$mainMod SHIFT, BackSpace, exec, ~/.config/hypr/scripts/switch-source"
  #       "$mainMod, BackSpace, exec, playerctl play-pause -a"
  #       "$mainMod SHIFT, S, exec, grimblast copy area"
  #       "ALT, Print, exec, grimblast copy screen"
  #     ];

  #     bindm = [
  #       "$mainMod, mouse:272, movewindow"
  #       "$mainMod, mouse:273, resizewindow"
  #     ];

  #     binde = [
  #       "$mainMod, equal, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
  #       "$mainMod, minus, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-"
  #     ];

  #     "windowrulev2" = "suppressevent maximize, class:.*"; # You'll probably like this.

  #     "exec-once" = [
  #       "waybar & "
  #       "waytrogen -r"
  #       "fcitx5 -d &"
  #       "sunshine &"
  #     ];

  #     "exec" = [
  #       "gen-color-scheme"
  #     ];

  #   };
  # };

  programs.kitty = {
    enable = true;
    font = {
      name = "Hasklug Nerd Font";
      size = 14;
    };
    themeFile = "Espresso";
    settings = {
      background_opacity = 0.75;
      confirm_os_window_close = 0;
    };
  };

  programs.git = {
    enable = true;
    userName = "aramis-matos";
    userEmail = "aramis.matos1@gmail.com";
  };

  programs.fuzzel = {
    enable = true;
    settings = {
      colors.background = "1e1e2edd";
      colors.text = "cdd6f4ff";
      colors.prompt = "bac2deff";
      colors.placeholder = "7f849cff";
      colors.input = "cdd6f4ff";
      colors.match = "74c7ecff";
      colors.selection = "585b70ff";
      colors.selection-text = "cdd6f4ff";
      colors.selection-match = "74c7ecff";
      colors.counter = "7f849cff";
      colors.border = "74c7ecff";
    };
  };

  programs.tmux = {
    enable = true;
    prefix = "C-Space";
    baseIndex = 1;
    sensibleOnTop = true;
    focusEvents = true;
    mouse = true;
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.mkTmuxPlugin {
          name = "tmux-menus";
          pluginName = "menus";
          src = fetchFromGitHub {
            owner = "jaclu";
            repo = "tmux-menus";
            rev = "v2.2.13";
            hash = "sha256-O6OL0zz9Ym592m6AKr6z1tTr6kB4EDPD7OBXQIeFn04=";
          };
        };
        extraConfig = ''
          set -g @menus_trigger 'Space'
          set -g @menus_use_cache 'No'
        '';
      }
      { plugin = inputs.minimal-tmux.packages.${pkgs.system}.default; }
    ];
    extraConfig = ''
      bind-key r source-file ~/.config/tmux/tmux.conf \; display-message "tmux.conf reloaded."

      bind -n M-h select-pane -L
      bind -n M-j select-pane -D
      bind -n M-k select-pane -U
      bind -n M-l select-pane -R

      bind-key \\ split-window -v -c "#{pane_current_path}"
      bind-key | split-window -h -c "#{pane_current_path}"

      bind -n S-Left previous-window
      bind -n S-Right next-window

      bind-key y set-window-option synchronize-panes\; display-message "synchronize mode toggled."
    '';
  };

  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 12.0;
        bold = {
          family = "Cousine Nerd Font";
          style = "Bold";
        };
        bold_italic = {
          family = "Cousine Nerd Font";
          style = "Bold Italic";
        };
        italic = {
          family = "Cousine Nerd Font";
          style = "Italic";
        };
        normal = {
          family = "Cousine Nerd Font";
          style = "Regular";
        };
      };
      window = {
        opacity = 0.9;
      };
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
