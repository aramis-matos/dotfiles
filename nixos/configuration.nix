# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  inputs,
  pkgs,
  lib,
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
    ];

  home-manager = {
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs; };
    users = {
      ${username} = import ./home.nix;
    };
  };

  # Bootloader.
  boot.loader.grub.enable = false;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    qt6Packages.fcitx5-configtool
    sbctl
  ];


  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  fonts.fontDir.enable = true;
  fonts = {
    packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.droid-sans-mono
      nerd-fonts.cousine
      nerd-fonts.hasklug
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
    ];
  };

  security.pki.certificates = [
    (builtins.readFile ./home-ca/home-ca.crt)
  ];


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
