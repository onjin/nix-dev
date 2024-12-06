{ pkgs ? import <nixpkgs> { } }:

import ./python.nix {
  inherit pkgs;
  pythonVersion = "python312";
  extraPackages = [ "pip" "virtualenv" ];
  isVenv = false;
}
