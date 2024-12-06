{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  name = "rust-stable";

  buildInputs = with pkgs; [ rust-bin.stable.latest.default ];

  # Optionally set environment variables to improve the dev experience
  shellHook = ''
    echo "Rust stable environment activated!"
  '';
}
