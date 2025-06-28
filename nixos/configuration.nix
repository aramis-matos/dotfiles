# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  inputs,
  pkgs,
  ...
}:
let
  username = "ccyanide";
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    ./system/services/ddclient.nix
    ./system/services/bluetooth.nix
    ./system/services/audio.nix
    ./system/users/users.nix
    ./system/vm/vm.nix
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
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;

  # nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  # environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    # neovim
    # wget
    # git
    # stow
    # arandr
    # brave
    # nodejs_22
    # gcc
    # playerctl
    # pulseaudio
    # pulsemixer
    # picom
    # gamemode
    # mangohud
    # cargo
    # prettierd
    # vscode.fhs
    # fastfetch
    # lazygit
    # vrrtest
    # kdePackages.kdenlive
    # flatpak
    # unzip
    # btop
    # wl-clipboard
    # xwayland
    # kitty
    # grimblast
    # waybar
    # rustup
    # heroic
    # waifu2x-converter-cpp
    # mpv
    # transmission_4-qt6
    # mullvad-vpn
    # filezilla
    # prismlauncher
    # nixfmt-rfc-style
    # radeontop
    # fuzzel
    # efibootmgr
    # fcitx5-configtool
    # discord
    # obs-studio
    # ffmpeg
    # erlang
    # elixir
    # nautilus
    # mpvpaper
    # lutris
    # bun
    # yazi
    # unrar
    # nixpkgs-fmt
    # fuzzel
    # hyprland-qtutils
    # waytrogen
    # pcsx2
    # speedcrunch
    # tmux
    # bottles
    # mgba
    # openssl
    # sshfs
    # protonup-qt
    # ethtool
    # xxd
    # protontricks
    # gimp-with-plugins
    # ncdu
    # waytrogen
    # pciutils
    # looking-glass-client
    # ripgrep
  ];

  #programs.dconf.settings.enable = true;

  fonts.fontDir.enable = true;
  fonts = {
    packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.droid-sans-mono
      nerd-fonts.cousine
      nerd-fonts.hasklug
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
    ];
  };

  # programs.direnv = {
  #   enable = true;
  #   nix-direnv.enable = true;
  # };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  # 3.11"; # Did you read the comment?
}
