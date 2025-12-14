# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  inputs,
  ...
}:
let
  username = import ./system/users/name.nix;
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
      inputs.lanzaboote.nixosModules.lanzaboote
      ./system/services/ddclient.nix
      ./system/services/bluetooth.nix
      ./system/services/audio.nix
      ./system/services/keyd.nix
      ./system/users/users.nix
      ./system/vm/vm.nix
      ./system/vm/k3s.nix
      ./system/networking/networking.nix
      ./system/display-manager/dm.nix
      ./system/locales/locales.nix
      ./system/keyboard/keyboard.nix
      ./system/gpu/nvidia.nix
      ./system/games/steam.nix
      ./system/games/sunshine.nix
      ./system/desktop-environments/hyprland.nix
      ./system/programs/fish/fish.nix
      ./system/programs/gnupg/gnupg.nix
      ./system/fonts/fonts.nix
      ./system/bootloader/bootloader.nix
    ];

  home-manager = {
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs; };
    users = {
      ${username} = import ./home.nix;
    };
  };


  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
