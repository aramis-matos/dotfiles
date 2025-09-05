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
      # "docker"
      "libvirtd"
      "libvirt"
      "input"
      "kvm"
      "acme"
      "podman"
    ];
    packages = with pkgs; [
      librewolf
      #  thunderbird
    ];
    shell = pkgs.fish;
  };
}
