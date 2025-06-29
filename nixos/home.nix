let
  username = import ./system/users/name.nix;
in
{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = username;
  home.homeDirectory = "/home/" + username;

  imports = [
    ./home/shells/direnv.nix
    ./home/shells/sh.nix
    ./home/shells/xdg.nix
    ./home/shells/prompt-theme/oh-my-posh.nix
    ./home/hyprland/hypr.nix
    ./home/hyprland/packages.nix
    ./home/terminals/kitty/kitty.nix
    ./home/terminals/alacritty/alacritty.nix
    ./home/fuzzel/fuzzel.nix
    ./home/keyboard/fcitx5.nix
    ./home/packages/dev-tools/haskell.nix
    ./home/packages/dev-tools/version-control.nix
    ./home/packages/dev-tools/rust.nix
    ./home/packages/dev-tools/nix.nix
    ./home/packages/dev-tools/javascript.nix
    ./home/packages/dev-tools/elixir.nix
    ./home/packages/dev-tools/latex.nix
    ./home/packages/dev-tools/editors.nix
    ./home/packages/sys-monitoring/monitoring.nix
    ./home/packages/games/games.nix
    ./home/packages/video-editing/editing.nix
    ./home/packages/networking/packages.nix
    ./home/packages/utils/packages.nix
    ./home/packages/vm/packages.nix
    ./home/programs/nvim/nvim.nix
    ./home/programs/tmux/tmux.nix
    ./home/programs/waybar/waybar.nix
  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  dev-tools = {
    haskell.enable = false;
    version-control.enable = true;
    rust.enable = false;
    nix.enable = true;
    elixir.enable = false;
    latex.enable = false;
    editors.enable = true;
  };

  system.monitoring.enable = true;
  networking.monitoring.enable = true;
  games.suite.enable = true;
  video.editing.enable = true;
  utils.suite.enable = true;
  windowManager.hyprland.enable = true;
  virtualisation.suite.enable = true;

  # home.packages = with pkgs; [
  # # Adds the 'hello' command to your environment. It prints a friendly
  # # "Hello, world!" when run.
  # pkgs.hello

  # # It is sometimes useful to fine-tune packages, for example, by applying
  # # overrides. You can do that directly here, just don't forget the
  # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
  # # fonts?
  # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

  # # You can also create simple shell scripts directly inside your
  # # configuration. For example, this adds a command 'my-hello' to your
  # # environment:
  # (pkgs.writeShellScriptBin "my-hello" ''
  #   echo "Hello, ${config.home.username}!"
  # '')
  # ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    Downloads.source = config.lib.file.mkOutOfStoreSymlink (
      config.home.homeDirectory + "/mass_storage/Downloads"
    );
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/ccyanide/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
    BROWSER = "${lib.getExe pkgs.librewolf}";
  };

  programs.git = {
    enable = true;
    userName = "aramis-matos";
    userEmail = "aramis.matos1@gmail.com";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
