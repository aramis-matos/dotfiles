{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.dev-tools.javascript.enable = lib.mkEnableOption "Enable Code Editors";

  config = lib.mkIf config.dev-tools.javascript.enable {
    home.packages = with pkgs; [
      bun
      nodejs_22
      gcc
    ];
  };
}
