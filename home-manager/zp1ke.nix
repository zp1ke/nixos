{ config, pkgs, ... }:

# https://nix-community.github.io/home-manager/options.xhtml
{
  imports = [
    ../modules/terminal.nix
  ];

  home.username = "zp1ke";
  home.homeDirectory = "/home/zp1ke";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    # Development
    git
    vscode

    # Internet
    firefox
  ];

  # Git configuration
  programs.git = {
    enable = true;
    userName = "Matt Atcher";
    userEmail = "zp1ke@proton.me";
    extraConfig = {
      core.editor = "code --wait";
      init.defaultBranch = "main";
      merge.conflictstyle = "zdiff3";
      pull.rebase = true;
    };
  };

  programs.firefox.enable = true;
  programs.home-manager.enable = true;
}
