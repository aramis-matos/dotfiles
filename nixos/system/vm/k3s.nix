{ config, ... }:
let
  username = import ../users/name.nix;
in
{
  services.k3s = {
    enable = true;
    role = "server";
    extraFlags = toString [
      "--debug"
      "--disable=traefik"
    ];
    autoDeployCharts = {
      nginx = {
        repo = "oci://ghcr.io/nginx/charts/nginx-ingress";
        version = "2.5.0";
        hash = "sha256-uLNv9t8mOqniY/3UT4SeQYwu1EGrl++rES8hIBZEJ1A=";
        values = {
          controller = {
            enableSnippets = true;
            service = {
              httpsPort = {
                port = "4443";
              };
              httpPort = {
                port = "8880";
              };
            };
          };
        };
      };
      cert-manager = {
        repo = "oci://quay.io/jetstack/charts/cert-manager";
        version = "v1.19.2";
        hash = "sha256-h+La+pRr0FxWvol7L+LhcfK7+tlsnUhAnUsRiNJAr28";
        targetNamespace = "cert-manager";
        createNamespace = true;
        values = {
          crds = {
            enabled = true;
          };
        };
      };
      longhorn = {
        repo = "https://charts.longhorn.io";
        name = "longhorn";
        version = "1.11.1";
        hash = "sha256-qT9gBS5ebjCNB+k/s+zA5NM2u9MjtyXwaJ3y5NaVJFs=";
        targetNamespace = "longhorn-system";
        createNamespace = true;
        values = {
          defaultSettings = {
            defaultDataPath = "/home/${username}/mass_storage/longhorn";
            defaultReplicaCount = 1;
            defaultClassReplicaCount = 1;
          };
        };
      };
    };
  };
  services.openiscsi = {
    enable = true;
    name = "${config.networking.hostName}-initiatorhost";
  };
  systemd.services.iscsid.serviceConfig = {
    PrivateMounts = "yes";
    BindPaths = "/run/current-system/sw/bin:/bin";
  };
}
