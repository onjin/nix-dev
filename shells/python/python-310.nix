{ pkgs ? import <nixpkgs> { } }:

import ./python.nix {
  inherit pkgs;
  pythonVersion = "python310";
  extraPackages = [ "pip" "virtualenv" ];
  isVenv = false;
}
