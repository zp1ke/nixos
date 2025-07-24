{ config, lib, pkgs, ... }:

let
  p10kFile = ./dotfiles/p10k.zsh;
in
{
  nixpkgs.config.allowUnfree = true;

  home = {
    packages = with pkgs; [
      kdePackages.ksshaskpass
      kdePackages.kwalletmanager
      keychain
      nerd-fonts.meslo-lg
      openfortivpn
      openssh
      zsh
      zsh-autosuggestions
      zsh-powerlevel10k
      zsh-syntax-highlighting
    ];

    sessionVariables = {
      SSH_ASKPASS = "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";
      SSH_ASKPASS_REQUIRE = "prefer";
    };

    file.".ssh/config" = {
      text = ''
        Host *
          AddKeysToAgent yes
          identityFile ~/.ssh/id_ed25519
          User git

        Host github.com
          HostName github.com
      '';
      onChange = ''
        chmod 600 ~/.ssh/config
      '';
    };

    file."/etc/open-fortivpn/config" = {
      text = ''
        host = HOST
        port = PORT
        username = USERNAME
        password = PASSWORD
        trusted-cert = TRUSTED_CERT
      '';
    };

    username = "zp1ke";
    homeDirectory = "/home/zp1ke";

    stateVersion = "25.05";
  };

  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Matt Atcher";
    userEmail = "zp1ke@proton.me";
    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
  };

  programs.ssh = {
    enable = true;
    forwardAgent = true;
    addKeysToAgent = "yes";
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519";
        identitiesOnly = true;
      };
    };
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
      eval $(keychain --eval --agents ssh id_ed25519)
    '';

    shellAliases = {
      ll = "ls -lah";
    };
  };

  programs.keychain = {
    enable = true;
    keys = [ "id_ed25519" ];
    agents = [ "ssh" ];
    inheritType = "any";
  };

  fonts = {
    fontconfig.enable = true;
  };

  services.ssh-agent.enable = true;
}
