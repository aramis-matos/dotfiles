{ pkgs, ... }:
let
  username = import ../users/name.nix;
in
{
  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.waydroid.enable = false;

  virtualisation.docker = {
    enable = true;
    liveRestore = false;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # virtualisation.oci-containers = {
  #   backend = "docker";
  #   containers = {
  #     startup = {
  #       image = "aramismatos/wake-on-lan:wol-test";
  #       ports = [ "3001:3001" ];
  #       autoStart = true;
  #       environment = {
  #         panda_MAC = "cc:28:aa:0d:23:dc";
  #       };
  #       extraOptions = [ "--network=host" ];
  #     };
  #   };
  # };

  programs.virt-manager.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
    };
  };

  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0660 ${username} qemu-libvirtd -"
  ];
}
