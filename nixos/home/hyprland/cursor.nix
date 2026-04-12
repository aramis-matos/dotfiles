{ pkgs, ... }:
{
  home.pointerCursor = {
    enable = true;
    name = "rose-pine-hyprcursor";
    package = pkgs.rose-pine-hyprcursor;
    hyprcursor = {
      enable = true;
      size = 28;
    };
  };
}
