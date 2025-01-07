{ pkgs ? import <nixpkgs> { } }:

import ./rust.nix {
  inherit pkgs;
  name = "rust-stable";
  package = pkgs.rust-bin.stable.latest.default.override {
    extensions = [ "rust-src" ];
  };
}
