{ pkgs ? import <nixpkgs> { } }:

import ./python.nix {
  inherit pkgs;
  pythonVersion = "python313";
  extraPackages = [ "pip" "virtualenv" ];
  isVenv = false;
}
