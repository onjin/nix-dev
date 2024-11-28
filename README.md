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


Or clone repository and use from path:

```shell
git clone https://github.com/onjin/nix-dev
cd nix-dev
nix develop .#python-312-venv
```

Integrate with https://direnv.net/:

```shell
$ cat .envrc 
use flake github:onjin/nix-dev#terraform-lsp
```

## Flake Templates

To initialize your project using template run:

```shell
nix flake new -t "github:onjin/nix-dev#python-shell" my-python-project
```

python:

 - python-shell
