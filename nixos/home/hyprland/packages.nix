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
      mpv
      mpvpaper
      waytrogen
      playerctl
      picom
      grimblast
      fuzzel
      yazi
      hyprland-qtutils
      fuzzel
      ffmpeg
      pulseaudio
      xwayland
      inputs.gen-color-scheme.packages.x86_64-linux.default
      inputs.switch-sinks.packages.x86_64-linux.default
    ];
  };
}
