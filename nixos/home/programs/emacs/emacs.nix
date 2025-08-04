{ ... }:
{
  home.file.emacs = {
    enable = true;
    source = ./scripts/init.el;
  };
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: with epkgs; [
    ];
  };

}
