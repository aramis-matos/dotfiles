{
  config,
  pkgs,
  lib,
  ...
}:
{

  options.games.suite.enable = lib.mkEnableOption "Enable support for games";

  config = lib.mkIf config.games.suite.enable {
    home.packages = with pkgs; [
      gamemode
      mangohud
      heroic
      # prismlauncher
      lutris
      pcsx2
      protonup-qt
      protontricks
      bottles
    ];
  };
}
