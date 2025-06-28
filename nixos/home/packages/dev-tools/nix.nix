{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.dev-tools.nix.enable = lib.mkEnableOption "Enable Nix Development";

  config = lib.mkIf config.dev-tools.nix.enable {
    home.packages = with pkgs; [
      nixpkgs-fmt
      nixfmt-rfc-style
      nil
    ];
  };
}
