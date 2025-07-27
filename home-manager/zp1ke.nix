{ config, pkgs, ... }:

# https://nix-community.github.io/home-manager/options.xhtml
{
  imports = [
    ../modules/terminal.nix
    ../modules/ssh.nix
    ../modules/git.nix
    ../modules/network.nix
  ];

  home.username = "zp1ke";
  home.homeDirectory = "/home/zp1ke";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    # Development
    vscode

    # Internet
    firefox
  ];

  programs.firefox.enable = true;
  programs.home-manager.enable = true;
}
