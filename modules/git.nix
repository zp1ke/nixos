{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    git
  ];

  programs.git = {
    enable = true;
    userName = "Matt Atcher";
    userEmail = "zp1ke@proton.me";

    extraConfig = {
      core.editor = "code --wait";
      init.defaultBranch = "main";
      merge.conflictstyle = "zdiff3";
      pull.rebase = true;
      push.default = "simple";
    };

    aliases = {
      # SSH key verification
      verify-ssh = "!echo 'Testing GitHub...' && ssh -T git@github.com 2>&1 | head -1 && echo 'Testing GitLab...' && ssh -T git@gitlab.com 2>&1 | head -1";
    };
  };
}
