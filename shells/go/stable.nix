{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "go-stable";

  buildInputs = with pkgs; [
    go
  ];

  # Optionally set environment variables to improve the dev experience
  shellHook = ''
    echo "Go stable environment activated!"
  '';
}
