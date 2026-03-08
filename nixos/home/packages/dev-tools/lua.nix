{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.dev-tools.lua.enable = lib.mkEnableOption "Enable Lua Development";

  config = lib.mkIf config.dev-tools.lua.enable {
    home.packages = with pkgs; [
      lua-language-server
    ];
  };
}
