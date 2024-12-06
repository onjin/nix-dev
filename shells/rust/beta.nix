{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  name = "rust-beta";

  buildInputs = with pkgs; [ rust-bin.beta.latest.default ];

  # Optionally set environment variables to improve the dev experience
  shellHook = ''
    echo "Rust beta environment activated!"
  '';
}
