{ ... }:
let
  shell_aliases = {
    update = "sudo nix flake update --flake /home/ccyanide/nixos/ && sudo nixos-rebuild switch --flake /home/ccyanide/nixos/#default";
    "..." = "cd ../..";
    code = "code --ozone-platform=wayland --enable-features=WaylandWindowDecorations";
  };
in
{
  programs.fish = {
    enable = true;
    shellAliases = shell_aliases;

    shellInit = ''
      set fish_greeting
      set -g fish_key_bindings fish_vi_key_bindings
    '';
  };

  programs.bash = {
    shellAliases = shell_aliases;
  };
}
