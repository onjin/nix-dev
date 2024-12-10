{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  name = "nodejs-20";

  buildInputs = [ pkgs.nodejs_20 pkgs.yarn pkgs.nodePackages.typescript ];
}
