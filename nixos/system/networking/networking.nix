{...}:
{
  networking.hostName = "panda"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.firewall.checkReversePath = "loose";
  networking.wireguard.enable = false;
  services.mullvad-vpn.enable = true;
  networking.interfaces.eno1.wakeOnLan.enable = true;
  networking.networkmanager.enable = true;

  networking.firewall.allowedTCPPorts = [
    6443
    8080
    2379
    2380
    4443
    8880
    47984
    47989
    47990
    48010
  ];
  networking.firewall.allowedUDPPorts = [
    8472
    4443
    8880
    51820
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

  networking.extraHosts = 
    ''
      127.0.0.1 jellyfin.minikube.lab.home
    '';
}
