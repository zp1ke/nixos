{ config, pkgs, ... }:

{
  # Terminal utilities
  home.packages = with pkgs; [
    bat
    eza
    ripgrep
  ];

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
      # History settings
      setopt HIST_IGNORE_DUPS
      setopt SHARE_HISTORY
      setopt HIST_EXPIRE_DUPS_FIRST
      setopt HIST_FIND_NO_DUPS
      setopt HIST_REDUCE_BLANKS

      # Better history search
      bindkey '^R' history-incremental-search-backward
      bindkey '^[[A' history-substring-search-up
      bindkey '^[[B' history-substring-search-down

      # Better navigation
      setopt AUTO_PUSHD
      setopt PUSHD_IGNORE_DUPS
    '';
  };

  # Starship prompt
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = true;
      format = "$all$character";
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
      nix_shell = {
        disabled = false;
        format = "via [$symbol$state]($style) ";
      };
      git_branch = {
        format = "on [$symbol$branch]($style) ";
        style = "bold purple";
      };
      directory = {
        style = "bold cyan";
        truncation_length = 3;
      };
    };
  };
}