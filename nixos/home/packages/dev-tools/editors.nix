{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.dev-tools.editors.enable = lib.mkEnableOption "Enable Code Editors";

  config = lib.mkIf config.dev-tools.editors.enable {
    home.packages = with pkgs; [
      prettierd
      vscode.fhs
      tmux
    ];
  };
}
