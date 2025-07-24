{ lib, pkgs, ... }:

let
  p10kFile = ./dotfiles/p10k.zsh;
in
{
  nixpkgs.config.allowUnfree = true;

  home = {
    packages = with pkgs; [
      zsh
      zsh-autosuggestions
      zsh-powerlevel10k
      zsh-syntax-highlighting
      nerd-fonts.meslo-lg
    ];

    username = "zp1ke";
    homeDirectory = "/home/zp1ke";

    stateVersion = "25.05";
  };

  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Matt Atcher";
    userEmail = "zp1ke@proton.me";
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    oh-my-zsh = {
      enable = true;
      theme = "";
      plugins = [ "git" "z" "sudo" ];
    };

    initContent = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      source ${p10kFile}
      source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
    '';

    shellAliases = {
      ll = "ls -lah";
    };
  };

  fonts = {
    fontconfig.enable = true;
  };
}
