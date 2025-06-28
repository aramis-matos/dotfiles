{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  options.windowManager.hyprland.enable = lib.mkEnableOption "Enable Hyprland";

  config = lib.mkIf config.windowManager.hyprland.enable {
      home.packages = with pkgs; [
        kitty
        wl-clipboard
        waybar
        mpv
        mpvpaper
        waytrogen
        playerctl
        picom
        grimblast
        fuzzel
        # fcitx5-configtool
        yazi
        inputs.gen-color-scheme.packages.x86_64-linux.default
        hyprland-qtutils
        fuzzel
        ffmpeg
        pulseaudio
        xwayland
      ];
    };
}
