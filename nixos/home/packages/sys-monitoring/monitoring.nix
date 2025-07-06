{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.system.monitoring.enable = lib.mkEnableOption "Enable system monitoring suite";

  config = lib.mkIf config.system.monitoring.enable {
    home.packages = with pkgs; [
      amdgpu_top
      btop
      pulsemixer
      ncdu
    ];
  };
}
