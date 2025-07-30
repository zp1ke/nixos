#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Check if Android Platform version is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <android_platform_version>"
  echo "Example: $0 36"
  echo "This will use the 'android-36' package from Nixpkgs."
  exit 1
fi

ANDROID_PLATFORM_VERSION=$1

# --- Create flake.nix ---
cat > flake.nix <<EOF
{
  description = "A Flutter development environment with Android ${ANDROID_PLATFORM_VERSION}";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          android_sdk.accept_license = true;
        };
        androidEnv = pkgs.androidenv.override { licenseAccepted = true; };
        androidComposition = androidEnv.composeAndroidPackages {
          platformToolsVersion = "${ANDROID_PLATFORM_VERSION}.0.0";
          buildToolsVersions = [ "${ANDROID_PLATFORM_VERSION}.0.0" ];
          platformVersions = [ "${ANDROID_PLATFORM_VERSION}" ];
          abiVersions = [ "armeabi-v7a" "arm64-v8a" ];
          includeNDK = false;
          includeSystemImages = false;
          systemImageTypes = [ "google_apis" "google_apis_playstore" ];
          includeEmulator = false;
          useGoogleAPIs = true;
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
        devShell = with pkgs; mkShell rec {
          ANDROID_HOME = "\${androidSdk}/libexec/android-sdk";
          ANDROID_SDK_ROOT = "\${androidSdk}/libexec/android-sdk";
          JAVA_HOME = jdk17.home;
          FLUTTER_ROOT = flutter;
          DART_ROOT = "\${flutter}/bin/cache/dart-sdk";
          GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=\${androidSdk}/libexec/android-sdk/build-tools/${ANDROID_PLATFORM_VERSION}.0.0/aapt2";

          buildInputs = [
            androidSdk
            flutter
            gradle
            jdk17
          ];

          shellHook = ''
            if [ -z "$PUB_CACHE" ]; then
              export PATH="$PATH:$HOME/.pub-cache/bin"
            else
              export PATH="$PATH:$PUB_CACHE/bin"
            fi
          '';
        };
      }
    );
}
EOF

echo "✅ Created flake.nix for Flutter with Android Platform ${ANDROID_PLATFORM_VERSION}."

# --- Create .envrc ---
cat > .envrc <<EOF
use flake
EOF

echo "✅ Created .envrc."
echo ""
echo "To finish setup, run the following command:"
echo "direnv allow"
