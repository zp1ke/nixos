#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Check if Node.js version is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <nodejs_version>"
  echo "Example: $0 18"
  echo "This will use the 'nodejs_18' package from Nixpkgs."
  exit 1
fi

NODE_VERSION_NUMBER=$1

# --- Create flake.nix ---
cat > flake.nix <<EOF
{
  description = "A Node.js development environment with Node.js ${NODE_VERSION_NUMBER}";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.\${system};
    in
    {
      devShells.\${system}.default = pkgs.mkShell {
        buildInputs = [
          # Use the specified Node.js version
          pkgs.nodejs_${NODE_VERSION_NUMBER}

          # You can add other tools like npm or yarn here if needed
        ];
      };
    };
}
EOF

echo "✅ Created flake.nix for Node.js ${NODE_VERSION_NUMBER}."

# --- Create .envrc ---
cat > .envrc <<EOF
use flake
EOF

echo "✅ Created .envrc."
echo ""
echo "To finish setup, run the following command:"
echo "direnv allow"
