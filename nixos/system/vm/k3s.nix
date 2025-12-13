{ ... }:
{
  services.k3s = {
    enable = false;
    role = "server";
    extraFlags = toString [
      "--debug"
      "--disable=traefik"
    ];
    autoDeployCharts = {
      nginx = {
        repo = "oci://ghcr.io/nginx/charts/nginx-ingress";
        version = "2.4.0";
        hash = "sha256-H8bsaxPV6l57DP3zkkJlZ59JGjhgu1l7tDerYxl5dcg";
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
    };
  };
}
