{ pkgs ? import <nixpkgs> { } }:

import ./python.nix {
  inherit pkgs;
  pythonVersion = "python311";
  extraPackages = [ "pip" "virtualenv" ];
  isVenv = false;
}
