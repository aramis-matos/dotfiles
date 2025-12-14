{lib,pkgs,...}:
{

  # Bootloader.
  boot.loader.grub.enable = false;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
}