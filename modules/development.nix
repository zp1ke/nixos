{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Docker and Docker Compose command-line tools.
    # The Docker daemon must be enabled in your system-level NixOS configuration for Docker to function.
    docker
    docker-compose

    vscode

    # Direnv and Nix Direnv for environment management
    direnv
    nix-direnv
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
