{pkgs,...}:
let
  username = import ./name.nix;
in
{
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "libvirtd"
      "libvirt"
      "input"
      "kvm"
      "acme"
    ];
    packages = with pkgs; [
      # librewolf-bin
      #  thunderbird
    ];
    shell = pkgs.fish;
  };
}
