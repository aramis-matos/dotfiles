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
    withPython3 = false;
    withRuby = false;
    viAlias = true;
    vimAlias = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    initLua = lib.fileContents ./init.lua;
    plugins = with pkgs.vimPlugins; [
      blink-cmp
    ];
    extraPackages = with pkgs; [
      lazygit
      typos-lsp
      helm-ls
    ];
  };
}
