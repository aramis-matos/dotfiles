{...}:

{

  imports = [
    ./plugins.nix
  ];

  programs.tmux = {
    enable = true;
    prefix = "C-Space";
    baseIndex = 1;
    sensibleOnTop = true;
    focusEvents = true;
    mouse = true;
    extraConfig = ''
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
    '';
  };
}