{ pkgs, inputs, ... }:
{
  programs.tmux.plugins = with pkgs; [
    {
      plugin = tmuxPlugins.mkTmuxPlugin {
        name = "tmux-menus";
        pluginName = "menus";
        src = fetchFromGitHub {
          owner = "jaclu";
          repo = "tmux-menus";
          rev = "v2.2.13";
          hash = "sha256-O6OL0zz9Ym592m6AKr6z1tTr6kB4EDPD7OBXQIeFn04=";
        };
      };
      extraConfig = ''
        set -g @menus_trigger 'Space'
        set -g @menus_use_cache 'No'
      '';
    }
    { plugin = inputs.minimal-tmux.packages.${pkgs.system}.default; }
  ];
}
