{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.dev-tools.python.enable = lib.mkEnableOption "Enable Python Development";

  config = lib.mkIf config.dev-tools.python.enable {
    home.packages = with pkgs; [
      python3
    ];
  };
}