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
      unzip
      unrar
      speedcrunch
      ripgrep
      nautilus
      tree
      linuxKernel.packages.linux_zen.xpadneo
      ntfs3g
    ];
  };
}
