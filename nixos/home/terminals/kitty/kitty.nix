{ ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "Hasklug Nerd Font";
      size = 14;
    };
    themeFile = "Espresso";
    settings = {
      background_opacity = 0.75;
      confirm_os_window_close = 0;
    };
  };
}
