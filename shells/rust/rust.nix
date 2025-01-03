{ pkgs, name, package }:

pkgs.mkShell {
  name = name;

  buildInputs = with pkgs; [ package ];
  packages = [
    # If the dependencies need system libs, you usually need pkg-config + the lib
    pkgs.pkg-config
    pkgs.openssl
    pkgs.clang
    pkgs.lld
  ];
  env = { RUST_BACKTRACE = "full"; };

  # Optionally set environment variables to improve the dev experience
  shellHook = ''
    echo "Rust ${name} environment activated!"
  '';
}

