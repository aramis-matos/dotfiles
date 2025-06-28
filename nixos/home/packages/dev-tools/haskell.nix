{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.dev-tools.haskell.enable = lib.mkEnableOption "Enable Haskell Development";

  config = lib.mkIf config.dev-tools.haskell.enable {
    home.packages = with pkgs; [
      haskell-language-server
      ghc
    ];
  };
}
