{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.dev-tools.version-control.enable = lib.mkEnableOption "Enable version control";

  config = lib.mkIf config.dev-tools.version-control.enable {
    home.packages = with pkgs; [
      wget
      lazygit
      git-crypt
    ];
  };

}
