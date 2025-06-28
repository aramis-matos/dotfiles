{pkgs,...}:
let
  username = "ccyanide";
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
      librewolf
      #  thunderbird
    ];
    shell = pkgs.fish;
  };
}
