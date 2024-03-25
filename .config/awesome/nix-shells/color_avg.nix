{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  packages = with pkgs; [ 
    python311
    python311Packages.pillow
    python311Packages.numpy
  ];
  # shellHook = ''
  #   python3 color_avg.py
  #   exit
  # '';
}
