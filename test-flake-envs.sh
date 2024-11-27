#!/usr/bin/env bash

set -euo pipefail

# Directory containing your flake
FLAKE_DIR=$(dirname "$0")

# Get the current system (e.g., x86_64-linux)
current_system=$(nix eval --raw nixpkgs#system)

# Get the list of environments for the current system using `nix flake show`
envs=$(nix flake show --json --all-systems "$FLAKE_DIR" | jq -r --arg system "$current_system" '.devShells[$system] | keys | .[]')

if [ -z "$envs" ]; then
  echo "No environments found for system: $current_system"
  exit 1
fi

# Iterate over all environments and attempt to start them
for env in $envs; do
  echo "Testing environment: $env"
  nix develop "$FLAKE_DIR#$env" --command echo "$env environment works!"
done

echo "All environments tested successfully."
