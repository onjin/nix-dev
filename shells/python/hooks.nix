{ pkgs, lib-path ? null, pythonEnv ? null }: {
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

    # venv directory parameter
    VENVDIR=$NIX_DEV_PYTHON_VENVDIR

    if [ -z $VENVDIR ]; then
      VENVDIR="./.venv"
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
    if [ ! -z "$NIX_DEV_PYTHON_REQUIREMENTS" ]; then
      echo "[nix-dev] Installing packages from NIX_DEV_PYTHON_REQUIREMENTS=$NIX_DEV_PYTHON_REQUIREMENTS"
      $VENVDIR/bin/pip install $NIX_DEV_PYTHON_REQUIREMENTS
    fi
    if [ ! -z "$NIX_DEV_PYTHON_REQUIREMENTS_TXT" ]; then
      echo "[nix-dev] Installing packages from NIX_DEV_PYTHON_REQUIREMENTS_TXT=$NIX_DEV_PYTHON_REQUIREMENTS_TXT"
      $VENVDIR/bin/pip install -r $NIX_DEV_PYTHON_REQUIREMENTS_TXT
    fi
  '';

}
