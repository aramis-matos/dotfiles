{ pkgs, ... }:
{
  systemd.timers."clean-k8s" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "15m";
      Persistent = true;
    };
  };

  systemd.services."clean-k8s" = {
    script = ''
      namespaces=("default" "kube-system" "cert-manager" "longhorn-system" "dns")

      KUBECONFIG="/etc/rancher/k3s/k3s.yaml"

      for namespace in "''${namespaces[@]}"; do
          ${pkgs.kubectl}/bin/kubectl --kubeconfig "$KUBECONFIG" -n "$namespace" get po | \
          grep -vE '(NAME|Running|Terminating)' | \
          ${pkgs.gawk}/bin/awk '{print $1}' | \
          xargs -I % kubectl --kubeconfig "$KUBECONFIG"  -n "$namespace" delete pod %;
      done
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };
}
