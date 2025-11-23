{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.dev-tools.elixir.enable = lib.mkEnableOption "Enable Elixir/Erlang Development";

  config = lib.mkIf config.dev-tools.elixir.enable {
    home.packages = with pkgs; [
      erlang
      elixir
      beam27Packages.elixir-ls
    ];
  };
}
