{ inputs, pkgs, ... }:
{
  programs.zen-browser = {
    enable = true;
    profiles.default = {
      extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
        ublock-origin
        bitwarden
      ];
      isDefault = true;
      name = "default";
      id = 0;
      settings = {
        "zen.view.compact.enable-at-startup" = true;
        "zen.view.compact.hide-toolbar" = true;
        "zen.view.compact.toolbar-flash-popup" = true;
        "zen.view.sidebar-expanded" = false;
      };
    };
    policies = {
      EnableTrackingProtection = {
        Value = true;
        Locked = false;
        Cryptomining = true;
        Fingerprinting = true;
        EmailTracking = true;
        SuspectedFingerprinting = true;
        Category = "standard";
        BaselineExceptions = false;
        ConvenienceExceptions = false;
      };
      GenerativeAI = {
        Enabled = false;
      };
      PasswordManagerEnabled = false;
      Homepage = {
        StartPage = "none";
      };
      Preferences = {
        "layout.css.prefers-color-scheme.content-override" = 0;
      };
    };
  };
}
