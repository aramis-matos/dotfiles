{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.virtualisation.suite.enable = lib.mkEnableOption "Enable VM tooling";

  config = lib.mkIf config.virtualisation.suite.enable {
    home.packages = with pkgs; [
      pciutils
      looking-glass-client
      kubernetes-helm
    ];
  };
}
