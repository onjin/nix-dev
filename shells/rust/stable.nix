{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  name = "rust-stable";

  buildInputs = with pkgs; [ rust-bin.stable.latest.default ];
  packages = [
    # If the dependencies need system libs, you usually need pkg-config + the lib
    pkgs.pkg-config
    pkgs.openssl
  ];

  # Optionally set environment variables to improve the dev experience
  shellHook = ''
    echo "Rust stable environment activated!"
  '';
}
