{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.zsh.enable = true;

  users.users.zp1ke.shell = pkgs.zsh;

  environment.shells = with pkgs; [ zsh ];

  environment.systemPackages = with pkgs; [
    neovim
    home-manager
    git
    gnumake
  ];

  programs.firefox = {
    enable = true;

    preferences = {
      "widget.use-xdg-desktop-portal.file-picker" = 1; 
    };
  };
}
