
{ pkgs ? import <nixpkgs> { } }:
let
  pythonPkg = pkgs.python313;
  pythonEnv = pythonPkg.withPackages (pythonPkgs:
    with pythonPkgs; [
      pip
      virtualenv
      # add nix python packages to install with python
    ]);
  lib-path = with pkgs; lib.makeLibraryPath [ libffi openssl stdenv.cc.cc ];
in pkgs.mkShell {
  name = "python-313-venv";
  packages = [ pkgs.bashInteractive ];
  buildInputs = with pkgs; [ pythonEnv ];
  shellHook = ''

    # Allow the use of wheels.
    SOURCE_DATE_EPOCH=$(date +%s)

    # Augment the dynamic linker path
    export "LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${lib-path}"

    # Create local venv
    VENV=$PWD/.venv
    if test ! -d $VENV; then
      ${pythonEnv}/bin/virtualenv $VENV
      echo "$VENV created with python $($VENV/bin/python --version)"
    else
      echo "$VENV already exists with python $($VENV/bin/python --version)"
    fi
    source $VENV/bin/activate
    export PYTHONPATH=$VENV/${pythonEnv.sitePackages}/:$PYTHONPATH
    export PATH=$VENV/bin:$PATH
  '';
}
