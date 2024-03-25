{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  packages = with pkgs; [ 
    scrot
    xclip
  ];
  # shellHook = ''
  #   python3 color_avg.py
  #   exit
  # '';
}
