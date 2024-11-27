{
  description = "Shared Nix Shell Environments";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { nixpkgs, flake-utils, ... }:
    let
      systems = flake-utils.lib.eachDefaultSystem (system:
        let
          # Default pkgs
          pkgs = import nixpkgs { system = system; };

          # Unfree-enabled pkgs
          pkgsUnfree = import nixpkgs {
            system = system;
            config = { allowUnfree = true; };
          };

        in {
          devShells = {
            terraform-lsp =
              import ./shells/terraform/lsp.nix { inherit pkgsUnfree; };
            # java
            java = import ./shells/java/jdk23.nix { inherit pkgs; };
            java-23 = import ./shells/java/jdk23.nix { inherit pkgs; };
            java-21 = import ./shells/java/jdk21.nix { inherit pkgs; };
            java-17 = import ./shells/java/jdk17.nix { inherit pkgs; };
            java-11 = import ./shells/java/jdk11.nix { inherit pkgs; };

            # python
            python-venv = import ./shells/python/python-312-venv.nix { inherit pkgs; };
            python-312-venv = import ./shells/python/python-312-venv.nix { inherit pkgs; };
          };
        });
    in {
      inherit (systems) devShells;

      templates = {
        python-shell = {
          path = ./python/shell;
          description = "Python shell flake";
        };
      };
    };

}

