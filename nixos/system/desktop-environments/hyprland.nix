{ lib, ... }:
{
  programs.hyprland = {
    # Install the packages from nixpkgs
    enable = true; # Whether to enable XWayland
    withUWSM = true;
    xwayland.enable = true;
  };
  programs.xwayland.enable = true;
  services.xserver.enable = true;

  environment.sessionVariables = lib.mkDefault {
    NIXOS_OZONE_WL = "1";
  };
}
