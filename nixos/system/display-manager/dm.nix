{ ... }:
let
  username = import ../users/name.nix;
in
{
  # services.displayManager.gdm = {
  #   enable = true;
  # };

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
