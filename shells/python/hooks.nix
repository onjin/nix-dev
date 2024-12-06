{ pkgs, lib-path ? null, pythonEnv ? null }:
let
  # Read environment variables for remote usage
  venvDir = builtins.getEnv "NIX_DEV_PYTHON_VENVDIR";
  requirements = builtins.getEnv "NIX_DEV_PYTHON_REQUIREMENTS";
  requirementsTxt = builtins.getEnv "NIX_DEV_PYTHON_REQUIREMENTS_TXT";
in {
  libPathHook = ''
    if [ ! -z "${lib-path}" ]; then
      # Augment the dynamic linker path
      export "LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${lib-path}"
      echo "[nix-dev] Library path set to ${lib-path}"
    else
      echo "[nix-dev] Skip library path"
    fi
  '';

  venvHook = ''
    SOURCE_DATE_EPOCH=$(date +%s)

    if [ -z ${venvDir} ]; then
      VENVDIR="./.venv"
    else
      VENVDIR="${venvDir}"
    fi

    if [ -d "$VENVDIR" ]; then
      echo "[nix-dev] Skipping venv creation, '$VENVDIR' already exists"
    else
      echo "[nix-dev] Creating new venv environment in path: '$VENVDIR'"
      # Note that the module venv was only introduced in python 3, so for 2.7
      # this needs to be replaced with a call to virtualenv
      ${pythonEnv.interpreter} -m venv "$VENVDIR"
    fi

    # Under some circumstances it might be necessary to add your virtual
    # environment to PYTHONPATH, which you can do here too;
    # PYTHONPATH=$PWD/$VENVDIR/${pythonEnv.sitePackages}/:$PYTHONPATH

    source "$VENVDIR/bin/activate"
  '';

  requirementsHook = ''
    # Install requirements.txt if exists
    if [ -f requirements.txt ];
      $VENVDIR/bin/pip install -r requirements.txt
    fi
  '';

  envRequirementsHook = ''
    # Install packages defined in env variable
    if [ ! -z "${requirements}" ]; then
      echo "[nix-dev] Installing packages from NIX_DEV_PYTHON_REQUIREMENTS=${requirements}"
      $VENVDIR/bin/pip install ${requirements}
    fi

    if [ ! -z "${requirementsTxt}" ]; then
      echo "[nix-dev] Installing packages from NIX_DEV_PYTHON_REQUIREMENTS_TXT=${requirementsTxt}"
      $VENVDIR/bin/pip install -r ${requirementsTxt}
    fi
  '';

}
