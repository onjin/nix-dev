{ pkgs ? import <nixpkgs> { } }:

import ./rust.nix {
  inherit pkgs;
  name = "rust-beta";
  package =
    pkgs.rust-bin.beta.latest.default.override { extensions = [ "rust-src" ]; };
}
