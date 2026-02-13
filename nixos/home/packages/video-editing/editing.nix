{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.video.editing.enable = lib.mkEnableOption "Enable video/image editing";

  config = lib.mkIf config.video.editing.enable {
    home.packages = with pkgs; [
      # gimp-with-plugins
      obs-studio
      waifu2x-converter-cpp
      # kdePackages.kdenlive
    ];
  };
}
