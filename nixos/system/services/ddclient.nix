{ ... }:
let
  username = import ../users/name.nix;
in
{
  services.ddclient = {
    enable = true;
    ssl = true;
    usev6 = "webv6, webv6=https://cloudflare.com/cdn-cgi/trace";
    protocol = "cloudflare";
    zone = "aramismatos1.com";
    passwordFile = "/home/ccyanide/ddclient_password";
    domains = [
      "aramismatos1.com"
      "*.aramismatos1.com"
    ];
  };
}
