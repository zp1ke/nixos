{ config, pkgs, inputs, ... }:

# https://nix-community.github.io/home-manager/options.xhtml
{
  imports = [
    (inputs.self + "/modules/theme.nix")
    (inputs.self + "/modules/terminal.nix")
    (inputs.self + "/modules/ssh.nix")
    (inputs.self + "/modules/git.nix")
    (inputs.self + "/modules/network.nix")
    (inputs.self + "/modules/cloud.nix")
    (inputs.self + "/modules/development.nix")
  ];

  home.username = "zp1ke";
  home.homeDirectory = "/home/zp1ke";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    firefox
  ];

  programs.firefox.enable = true;
  programs.home-manager.enable = true;
}
