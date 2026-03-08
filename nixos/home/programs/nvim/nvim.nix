{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    initLua = lib.fileContents ./init.lua;
    plugins = with pkgs.vimPlugins; [
      blink-cmp
    ];
    extraPackages = with pkgs; [
      lazygit
    ];
  };
}
