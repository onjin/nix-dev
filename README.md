# My nix dev stuff

The dev shells and templates which I'm using across different projects. Gathered here instead of writing the same flake/shell in multiple projects.

To list available shells & templates run:
```shell
nix flake show github:onjin/nix-dev
```

## Flake Shells

To use the shells from remote run:

```shell
nix develop "github:onjin/nix-dev#python-312-venv"
```

**Python flakes' environment variables**:

To pass variables into flake you need to use `--impure` flag.

- `NIX_DEV_PYTHON_VENVDIR=~/.local/share/myenv` - overwrite `./.venv` default for `...-env` python flakes
- `NIX_DEV_PYTHON_REQUIREMENTS_TXT=requirements.txt` - run `pip install -r ...` for file name set as variable
- `NIX_DEV_PYTHON_REQUIREMENTS="uv anyio"` - run `pip install ...` for list of packages

Or clone repository and use from path:

```shell
git clone https://github.com/onjin/nix-dev
cd nix-dev
nix develop .#python-312-venv
```

Integrate with https://direnv.net/:

```shell
$ cat .envrc 
export NIX_DEV_PYTHON_VENVDIR=~/.local/share/myenv
export NIX_DEV_PYTHON_REQUIREMENTS_TXT=requirements.txt
export NIX_DEV_PYTHON_REQUIREMENTS="uv anyio"
use flake github:onjin/nix-dev#python-313-venv --impure
```

## Flake Templates

To initialize your project using template run:

```shell
nix flake new -t "github:onjin/nix-dev#python-shell" my-python-project
```

python:

 - python-shell
