
{ pkgs ? import <nixpkgs> { } }:
let
  pythonPkg = pkgs.python312;
  pythonEnv = pythonPkg.withPackages (pythonPkgs:
    with pythonPkgs; [
      pip
      virtualenv
      # add nix python packages to install with python
    ]);
  lib-path = with pkgs; lib.makeLibraryPath [ libffi openssl stdenv.cc.cc ];
in pkgs.mkShell {
  name = "python-312";
  packages = [ pkgs.bashInteractive ];
  buildInputs = with pkgs; [ pythonEnv ];
  shellHook = ''

    # Allow the use of wheels.
    SOURCE_DATE_EPOCH=$(date +%s)

    # Augment the dynamic linker path
    export "LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${lib-path}"
  '';
}
