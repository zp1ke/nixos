#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Create flake.nix ---
cat > flake.nix <<EOF
{
  description = "Flutter development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    android-nixpkgs.url = "github:tadfisher/android-nixpkgs";
  };

  outputs = { self, nixpkgs, android-nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.\${system};
    in
    {
      devShells.\${system}.default = pkgs.mkShell {
        buildInputs = [
          firebase-tools
          flutter
        ];
      };

      packages.x86_64-linux.android-sdk = android-nixpkgs.\${system} (sdkPkgs: with sdkPkgs; [
        cmdline-tools-latest
        build-tools-34-0-0
        platform-tools
        platforms-android-34
      ]);
    };
}
EOF

echo "✅ Created flake.nix for Flutter with android SDK."

# --- Create .envrc ---
cat > .envrc <<EOF
use flake
EOF

echo "✅ Created .envrc."
echo ""
echo "To finish setup, run the following command:"
echo "direnv allow"
