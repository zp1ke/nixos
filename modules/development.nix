{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    # Docker and Docker Compose command-line tools.
    # The Docker daemon must be enabled in your system-level NixOS configuration for Docker to function.
    docker
    docker-compose

    android-studio
    android-tools
    dbeaver-bin
    flutter
    github-desktop
    jetbrains.idea-community
    vscode

    # Direnv and Nix Direnv for environment management
    direnv
    nix-direnv

    # Script to set up a JDK environment for a project
    (pkgs.writeShellScriptBin "setup-jdk-env" (builtins.readFile ./scripts/setup_jdk_env.sh))

    # Script to set up a NodeJS environment for a project
    (pkgs.writeShellScriptBin "setup-nodejs-env" (builtins.readFile ./scripts/setup_nodejs_env.sh))
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Enable ADB for Android development
  programs.adb.enable = true;

  # Environment variables for Android SDK
  home.sessionVariables = {
    ANDROID_HOME = "${config.home.homeDirectory}/Android/Sdk";
    ANDROID_SDK_ROOT = "${config.home.homeDirectory}/Android/Sdk";
    FLUTTER_ROOT = "${pkgs.flutter}";
  };

  # Add Android SDK tools to PATH
  home.sessionPath = [
    "$ANDROID_HOME/emulator"
    "$ANDROID_HOME/platform-tools"
    "$ANDROID_HOME/tools"
    "$ANDROID_HOME/tools/bin"
  ];

  # Create Android SDK directory
  home.activation = {
    createAndroidSdkDir = lib.hm.dag.entryAfter ["writeBoundary"] ''
      mkdir -p $HOME/Android/Sdk
    '';
  };

  # Flutter configuration
  programs.flutter = {
    enable = true;
    platform = "android";
    channel = "stable";
    dart-sdk = pkgs.dart;
  };
}
