{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  name = "nodejs-23";

  buildInputs = [ pkgs.nodejs_23 pkgs.yarn pkgs.nodePackages.typescript ];
}
