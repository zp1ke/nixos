#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Check if build tools version is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <build_tools_version>"
  echo "Example: $0 34.0.0"
  exit 1
fi

BUILD_TOOLS_VERSION=$1
# We can derive a reasonable platform version from the build tools major version.
PLATFORM_VERSION=$(echo "$BUILD_TOOLS_VERSION" | cut -d'.' -f1)

# --- Create flake.nix ---
cat > flake.nix <<EOF
{
  description = "A Flutter development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.\${system};

        # Declaratively compose the exact Android SDK needed for this project.
        androidSdk = pkgs.androidenv.composeAndroidPackages {
          platform-tools = true;
          cmdline-tools = true;
          build-tools-version = "${BUILD_TOOLS_VERSION}";
          platforms-version = "${PLATFORM_VERSION}";
          # Add other components like 'emulator' or 'system-images' here if needed.
        };
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = [
            pkgs.flutter
            pkgs.jdk17 # Adjust JDK version as needed
            androidSdk
          ];

          # Set the required environment variables within the shell.
          shellHook = ''
            export ANDROID_SDK_ROOT="\${androidSdk}/share/android-sdk"
            export ANDROID_HOME="\${androidSdk}/share/android-sdk" # Deprecated, but some tools might still use it.
            echo "Flutter environment loaded."
            echo "Run 'flutter doctor' to verify."
          '';
        };
      }
    );
}
EOF

echo "✅ Created flake.nix for Flutter with build tools v\${BUILD_TOOLS_VERSION}."

# --- Create .envrc ---
cat > .envrc <<EOF
use flake
EOF

echo "✅ Created .envrc."
echo ""
echo "To finish setup, run the following command:"
echo "direnv allow"
