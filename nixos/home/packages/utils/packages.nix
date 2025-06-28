{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.utils.suite.enable = lib.mkEnableOption "Enable misc utilities";

  config = lib.mkIf config.utils.suite.enable {
    home.packages = with pkgs; [
      stow
      arandr
      brave
      fastfetch
      vrrtest
      flatpak
      unzip
      efibootmgr
      unrar
      speedcrunch
      ripgrep
      nautilus
      tree
      pulseaudio
    ];
  };
}
