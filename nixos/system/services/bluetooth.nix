{pkgs,...}:
{
  # Enable Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
  #   systemd.user.services.mpris-proxy = {
  #     description = "Mpris proxy";
  #     after = [ "network.target" "sound.target" ];
  #     wantedBy = [ "default.target" ];
  #     serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  # };

  systemd.user.services = {
    mpris-proxy = {
      description = "Mpris proxy";
      after = [
        "network.target"
        "sound.target"
      ];
      wantedBy = [ "default.target" ];
      serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
    };
  };
}