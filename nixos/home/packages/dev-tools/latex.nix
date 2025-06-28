{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.dev-tools.latex.enable = lib.mkEnableOption "Enable LaTex Development";

  config = lib.mkIf config.dev-tools.latex.enable {
    home.packages = with pkgs; [
      texlive.combined.scheme-full
    ];
  };
}
