{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.networking.monitoring.enable = lib.mkEnableOption "Enable network monitoring";

  config = lib.mkIf config.networking.monitoring.enable {
    home.packages = with pkgs; [
      ethtool
      xxd
      openssl
      sshfs
      transmission_4-qt6
      filezilla
      mullvad-vpn
    ];
  };
}
