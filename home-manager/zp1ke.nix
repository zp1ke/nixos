{ config, pkgs, ... }:

# https://nix-community.github.io/home-manager/options.xhtml
{
  home.username = "zp1ke";
  home.homeDirectory = "/home/zp1ke";

  # https://nix-community.github.io/home-manager/options.xhtml#opt-home.stateVersion
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    # Utilities
    bat
    eza
    ripgrep

    # Development
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
      init.defaultBranch = "main";
      pull.rebase = true;
      merge.conflictstyle = "zdiff3";
    };
  };

  # Zsh configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
    ];

    shellAliases = {
      ll = "eza -la";
      cat = "bat";
      grep = "rg";
    };

    initContent = ''
      setopt HIST_IGNORE_DUPS
      setopt SHARE_HISTORY
      setopt HIST_EXPIRE_DUPS_FIRST
      # Better history search
      bindkey '^R' history-incremental-search-backward
    '';
  };

  # Starship prompt
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = "$all$character";
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
      nix_shell = {
        disabled = false;
        format = "via [$symbol$state]($style) ";
      };
    };
  };

  programs.firefox.enable = true;
  programs.home-manager.enable = true;
}
