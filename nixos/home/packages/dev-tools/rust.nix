{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.dev-tools.rust.enable = lib.mkEnableOption "Enable Rust Development";

  config = lib.mkIf config.dev-tools.rust.enable {
    home.packages = with pkgs; [
      rustc
      cargo
    ];
  };
}
