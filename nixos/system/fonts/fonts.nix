{pkgs, ...}:
{
  fonts.fontDir.enable = true;
  fonts = {
    packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.droid-sans-mono
      nerd-fonts.cousine
      nerd-fonts.hasklug
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
    ];
  };

  environment.systemPackages = with pkgs; [
    qt6Packages.fcitx5-configtool
  ];
}