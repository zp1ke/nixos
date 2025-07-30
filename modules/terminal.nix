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
      {
        name = "zsh-history-substring-search";
        src = pkgs.zsh-history-substring-search;
        file = "share/zsh-history-substring-search/zsh-history-substring-search.zsh";
      }
    ];

    shellAliases = {
      ll = "eza -la";
      cat = "bat";
      grep = "rg";
      nixos-clean = "sudo nix-collect-garbage -d";
      nixos-update = "sudo nixos-rebuild switch --flake /etc/nixos/#legion --upgrade";
    };

    initContent = ''
      # History settings
      setopt HIST_IGNORE_DUPS
      setopt SHARE_HISTORY
      setopt HIST_EXPIRE_DUPS_FIRST
      setopt HIST_FIND_NO_DUPS
      setopt HIST_REDUCE_BLANKS

      # Autosuggestion key bindings (Right arrow or End to accept)
      bindkey '^[[C' forward-char                    # Right arrow - accept one character
      bindkey '^[[1;5C' forward-word                 # Ctrl+Right arrow - accept one word
      bindkey '^E' end-of-line                       # Ctrl+E - accept entire suggestion

      # History substring search (only when you start typing)
      bindkey '^[[A' history-substring-search-up     # Up arrow
      bindkey '^[[B' history-substring-search-down   # Down arrow

      # Better history search
      bindkey '^R' history-incremental-search-backward

      # Better navigation
      setopt AUTO_PUSHD
      setopt PUSHD_IGNORE_DUPS

      # Configure autosuggestion behavior
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666666,underline"
      ZSH_AUTOSUGGEST_STRATEGY=(history completion)
      ZSH_AUTOSUGGEST_USE_ASYNC=true

      # Hook direnv into zsh
      eval "$(direnv hook zsh)"
    '';
  };

  # Starship prompt
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = true;
      format = "$all$character";
      right_format = "$duration";
      continuation_prompt = "[╰┈┈➤](bright-black) ";
      character = {
        success_symbol = "[➤](bold #026b00)";
        error_symbol = "[➤](bold #980200)";
      };
      nix_shell = {
        disabled = false;
        format = "❄︎ [$symbol$state]($style) ";
      };
      git_branch = {
        format = "𖦥 [$symbol$branch]($style) ";
        style = "bold #a626a4";
      };
      directory = {
        style = "bold #23b2d6ff";
        truncation_length = 3;
      };
    };
  };

  # Default Konsole profile
  home.file.".local/share/konsole/Default.profile" = {
    force = false;
    text = ''
      [General]
      Name=Default
      Parent=FALLBACK/
    '';
  };
}