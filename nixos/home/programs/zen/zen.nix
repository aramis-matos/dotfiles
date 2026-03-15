let
  extension = shortId: guid: {
    name = guid;
    value = {
      install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
      installation_mode = "normal_installed";
    };
  };

  prefs = {
    "zen.view.compact.enable-at-startup" = true;
    "zen.view.compact.hide-toolbar" = true;
    "zen.view.compact.toolbar-flash-popup" = true;
    "zen.view.sidebar-expanded" = false;
  };

  extensions = [
    (extension "ublock-origin" "uBlock0@raymondhill.net")
    (extension "bitwarden-password-manager" "{446900e4-71c2-419f-a6a7-df9c091e268b}")
  ];
in
{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  home.packages = [
    (pkgs.wrapFirefox
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.zen-browser-unwrapped
      {
        extraPrefs = lib.concatLines (
          lib.mapAttrsToList (
            name: value: "lockPref(${lib.strings.toJSON name}, ${lib.strings.toJSON value});"
          ) prefs
        );
        extraPolicies = {
          DisableTelemetry = true;
          ExtensionSettings = builtins.listToAttrs extensions;
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
      }
    )
  ];

}
