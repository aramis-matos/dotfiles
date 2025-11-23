{ pkgs,... }:
let
  packages = (epkgs: [
   (epkgs.treesit-grammars.with-grammars (grammars: with grammars; [ tree-sitter-bash tree-sitter-elixir tree-sitter-heex]))
    epkgs.tree-sitter-langs
   ]);

in
{
  home.file.emacs = {
    enable = true;
    source = ./scripts/init.el;
    target = ".config/emacs/init.el";
  };

  services.emacs = {
    enable = true;
    package = pkgs.emacs30.pkgs.withPackages packages;
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs30.pkgs.withPackages packages;
  };
}
