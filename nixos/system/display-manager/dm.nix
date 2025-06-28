{ ... }:
let
  username = "ccyanide";
in
{
  services.xserver.displayManager.lightdm = {
    enable = true;
  };

  services.displayManager = {
    autoLogin = {
      enable = true;
      user = username;
    };
    defaultSession = "hyprland";
  };
}
