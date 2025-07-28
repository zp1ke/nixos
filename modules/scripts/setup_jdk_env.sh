#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Check if JDK version is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <jdk_version_number>"
  echo "Example: $0 21"
  echo "This will use the 'jdk21' package from Nixpkgs."
  exit 1
fi

JDK_VERSION_NUMBER=$1
JDK_PACKAGE="jdk\${JDK_VERSION_NUMBER}"

# --- Create flake.nix ---
cat > flake.nix <<EOF
{
  description = "A Java development environment with JDK ${JDK_VERSION_NUMBER}";

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
          # Use the specified JDK version
          pkgs.${JDK_PACKAGE}

          # You can add other tools like Maven or Gradle here by editing this file
          # pkgs.maven
          # pkgs.gradle
        ];
      };
    };
}
EOF

echo "✅ Created flake.nix for JDK ${JDK_VERSION_NUMBER}."

# --- Create .envrc ---
cat > .envrc <<EOF
use flake
EOF

echo "✅ Created .envrc."
echo ""
echo "To finish setup, run the following command:"
echo "direnv allow"
