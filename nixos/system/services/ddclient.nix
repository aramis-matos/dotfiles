{ ... }:
let
  username = import ../users/name.nix;
in
{
  services.ddclient = {
    enable = true;
    ssl = true;
    usev4 = "webv4, webv4=https://cloudflare.com/cdn-cgi/trace";
    protocol = "cloudflare";
    zone = "aramismatos1.com";
    passwordFile = "/home/${username}/dotfiles/nixos/system/services/ddclient_password";
    domains = [
      "aramismatos1.com"
      "*.aramismatos1.com"
    ];
  };
}
