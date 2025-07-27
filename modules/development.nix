{ config, pkgs, ... }:

{
  # Docker and Docker Compose command-line tools.
  # The Docker daemon must be enabled in your system-level NixOS configuration for Docker to function.
  home.packages = with pkgs; [
    docker
    docker-compose
    vscode
  ];
}
