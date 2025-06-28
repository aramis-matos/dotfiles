{...}:
{
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.firewall.checkReversePath = "loose";
  networking.wireguard.enable = true;
  services.mullvad-vpn.enable = true;
  networking.interfaces.eno1.wakeOnLan.enable = true;
  networking.networkmanager.enable = true;

  networking.firewall.allowedTCPPorts = [
    4443
    8880
    47984
    47989
    47990
    48010
  ];
  networking.firewall.allowedUDPPorts = [
    4443
    8880
  ];
  networking.firewall.allowedUDPPortRanges = [
    {
      from = 47998;
      to = 48000;
    }
    {
      from = 8000;
      to = 8010;
    }
  ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;
}