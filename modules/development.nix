{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Docker and Docker Compose command-line tools.
    # The Docker daemon must be enabled in your system-level NixOS configuration for Docker to function.
    docker
    docker-compose

    android-studio
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

  # Flutter configuration
  programs.flutter = {
    enable = true;
    platform = "android";
    channel = "stable";
    dart-sdk = pkgs.dart;
  };
}
