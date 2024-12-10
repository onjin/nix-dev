{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  name = "nodejs-18";

  buildInputs = [ pkgs.nodejs_18 pkgs.yarn pkgs.nodePackages.typescript ];
}
