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
CMD_LINE_TOOLS_VERSION="latest"
PLATFORM_VERSION=$(echo "$BUILD_TOOLS_VERSION" | cut -d'.' -f1)

# --- Create flake.nix ---
cat > flake.nix <<EOF
{
  description = "Flutter development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            android_sdk.accept_license = true;
            allowUnfree = true;
          };
        };

        androidComposition = pkgs.androidenv.composeAndroidPackages {
          cmdLineToolsVersion = "${CMD_LINE_TOOLS_VERSION}";
          buildToolsVersions = [ "${BUILD_TOOLS_VERSION}" ];
          platformVersions = [ "${PLATFORM_VERSION}" ];
          abiVersions = [ "armeabi-v7a" "arm64-v8a" ];
          includeEmulator = false;
          includeSources = false;
          extraLicenses = [
            "android-googletv-license"
            "android-sdk-arm-dbt-license"
            "android-sdk-license"
            "android-sdk-preview-license"
            "google-gdk-license"
            "intel-android-extra-license"
            "intel-android-sysimage-license"
            "mips-android-sysimage-license"
          ];
        };
        androidSdk = androidComposition.androidsdk;
      in
      {
        devShell = with pkgs; mkShell {
          buildInputs = [
            androidSdk
            firebase-tools
            flutter
            jdk17
            mesa
            libigl
          ];

          shellHook = ''
            export ANDROID_SDK_ROOT="${androidSdk}/libexec/android-sdk"
            export ANDROID_HOME="${androidSdk}/libexec/android-sdk" # Deprecated, but good for compatibility
            export JAVA_HOME="${jdk17}"
            export PATH="${androidSdk}/libexec/android-sdk/platform-tools:$PATH"
            export PATH="${androidSdk}/libexec/android-sdk/cmdline-tools/latest/bin:$PATH"
            export PATH="${androidSdk}/libexec/android-sdk/emulator:$PATH"
            export PATH="$HOME/.pub-cache/bin:$PATH"
            echo "Flutter environment loaded."
          '';
        };
      }
    );
}
EOF

echo "✅ Created flake.nix for Flutter with build tools ${BUILD_TOOLS_VERSION}."

# --- Create .envrc ---
cat > .envrc <<EOF
use flake
EOF

echo "✅ Created .envrc."
echo ""
echo "To finish setup, run the following command:"
echo "direnv allow"
