{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  name = "nodejs-22";

  buildInputs = [ pkgs.nodejs_22 pkgs.yarn pkgs.nodePackages.typescript ];
}
