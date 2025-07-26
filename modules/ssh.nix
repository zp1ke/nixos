{ config, pkgs, ... }:

{
  # SSH configuration
  programs.ssh = {
    enable = true;

    # SSH client configuration
    extraConfig = ''
      # Default settings
      AddKeysToAgent yes
      UseKeychain yes
      IdentitiesOnly yes

      # Prevent timeout
      ServerAliveInterval 60
      ServerAliveCountMax 10
    '';

    # Host-specific configurations
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519";
        identitiesOnly = true;
      };

      "gitlab.com" = {
        hostname = "gitlab.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519";
        identitiesOnly = true;
      };
    };
  };

  # SSH agent service
  services.ssh-agent.enable = true;

  # SSH key generation script
  home.file.".ssh/generate_key.sh" = {
    source = ./scripts/generate_ssh_key.sh;
    executable = true;
  };

  # SSH connection test script
  home.file.".ssh/test_connections.sh" = {
    source = ./scripts/test_ssh_connections.sh;
    executable = true;
  };
}
