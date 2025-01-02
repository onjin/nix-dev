{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  name = "rust-beta";

  buildInputs = with pkgs; [ rust-bin.beta.latest.default ];
  packages = [
    # If the dependencies need system libs, you usually need pkg-config + the lib
    pkgs.pkg-config
    pkgs.openssl
  ];

  # Optionally set environment variables to improve the dev experience
  shellHook = ''
    echo "Rust beta environment activated!"
  '';
}
