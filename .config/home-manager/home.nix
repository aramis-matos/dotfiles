let username = "ccyanide"; in
{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home. username = username;
  home.homeDirectory = "/home/ccyanide";


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
  home.packages = with pkgs; [
    texlive.combined.scheme-full
    jdk
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
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home. file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
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
  home. sessionVariables = {
    # EDITOR = "emacs";
  };

  programs. kitty = {
    enable = true;
    font = {
      name = "Hasklug Nerd Font";
      size = 14;
    };
    themeFile = "Espresso";
    settings = {
      background_opacity = 0.75;
      confirm_os_window_close = 0;
    };
  };

  programs.git = {
    enable = true;
    userName = "aramis-matos";
    userEmail = "aramis.matos1@gmail.com";
  };

  programs.fuzzel = {
    enable = true;
    settings = {
      colors.background = "1e1e2edd";
      colors.text = "cdd6f4ff";
      colors.prompt = "bac2deff";
      colors.placeholder = "7f849cff";
      colors.input = "cdd6f4ff";
      colors.match = "74c7ecff";
      colors.selection = "585b70ff";
      colors.selection-text = "cdd6f4ff";
      colors.selection-match = "74c7ecff";
      colors.counter = "7f849cff";
      colors.border = "74c7ecff";
    };
  };

  programs.tmux = {
    enable = true;
    prefix = "C-Space";
    baseIndex = 1;
    sensibleOnTop = true;
    focusEvents = true;
    mouse = true;
    plugins = with pkgs; [
    {
      plugin = tmuxPlugins.tokyo-night-tmux;
      extraConfig = "set -g @theme-variation 'night'";
    }
    ];
    extraConfig = ''
      '''
      bind-key r source-file ~/.config/tmux/tmux.conf \; display-message "tmux.conf reloaded."
      
      bind -n M-h select-pane -L
      bind -n M-j select-pane -D
      bind -n M-k select-pane -U
      bind -n M-l select-pane -R
      
      bind-key \\ split-window -v -c "#{pane_current_path}"
      bind-key | split-window -h -c "#{pane_current_path}"
      
      bind -n S-Left previous-window
      bind -n S-Right next-window
      
      bind-key y set-window-option synchronize-panes\; display-message "synchronize mode toggled."
      '''
    '';
  };


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
