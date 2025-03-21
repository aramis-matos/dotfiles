# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, lib, config, pkgs, ... }:


{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.firewall.checkReversePath = "loose";
  networking.wireguard.enable = true;
  services.mullvad-vpn.enable = true;

  # nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  i18n.inputMethod = {
    enable = true;
    # type = "ibus";
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
      fcitx5-material-color
    ];
  };
  i18n.inputMethod.fcitx5.waylandFrontend = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  services.xserver.deviceSection = ''
    Option "TearFree" "true"
    Option "VariableRefresh" "true"
    Option "AsyncFlipSecondaries" "true"
  '';
  services.xserver.exportConfiguration = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;



  # Configure keymap in X11
  services.xserver = {
    xkb = {
      variant = "";
      layout = "us";
    };
    windowManager = {
      awesome.enable = true;
    };
  };

  environment.sessionVariables = lib.mkDefault rec {
    NIXOS_OZONE_WL = "1";
  };

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
      after = [ "network.target" "sound.target" ];
      wantedBy = [ "default.target" ];
      serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
    };
    polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };



  programs.hyprland = {
    # Install the packages from nixpkgs
    enable = true;
    # Whether to enable XWayland
    xwayland.enable = true;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  services.flatpak.enable = true;
  # Jellyfin

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ccyanide = {
    isNormalUser = true;
    description = "ccyanide";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" ];
    packages = with pkgs; [
      firefox
      #  thunderbird
    ];
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget



  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    neovim
    wget
    xclip
    git
    stow
    arandr
    rofi
    brave
    nodejs_22
    glxinfo
    nitrogen
    gcc
    playerctl
    alacritty
    pulseaudio
    pulsemixer
    picom
    gamemode
    mangohud
    bat
    rustc
    cargo
    prettierd
    vscode
    stylua
    leptosfmt
    fastfetch
    lazygit
    vrrtest
    (python311.withPackages (p: with p; [
      numpy
      pillow
      pyclip
    ]))

    kdePackages.kdenlive
    flatpak
    htop-vim
    unzip
    btop
    genymotion
    wl-clipboard
    xwayland
    kitty
    wev
    # hyprpaper
    grimblast
    waybar
    home-manager
    rustup
    haskell-language-server
    ghc
    heroic
    waifu2x-converter-cpp
    mpv
    transmission_4-qt6
    mullvad-vpn
    filezilla
    prismlauncher
    nixfmt-rfc-style
    radeontop
    fuzzel
    efibootmgr
    fcitx5-configtool
    discord
    obs-studio
    ffmpeg
    erlang
    elixir
    nautilus
    inotify-tools
    lzip
    mpvpaper
    lutris
    bun
    yazi
    unrar
    nixpkgs-fmt
    fuzzel
  ];

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

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      ccyanide = import ./home.nix;
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.fish = {
    enable = true;

    shellAliases = {
      update = "cd /etc/nixos/ ; sudo nix flake update && sudo nixos-rebuild switch --flake /etc/nixos#default ; home-manager switch; cd -";
      "..." = "cd ../..";
    };

    shellInit = "
set fish_greeting
set -g fish_key_bindings fish_vi_key_bindings
    ";
  };

  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };


  # Enable USB redirection (optional)
  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.waydroid.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };


  programs.gamemode.enable = true;

  programs.xwayland.enable = true;



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

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ];
  # networking.firewall.allowedUDPPorts = [ ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?


  # 3.11"; # Did you read the comment?

}
