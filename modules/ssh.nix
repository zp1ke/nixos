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

  # SSH utilities using external script files
  home.packages = [
    # SSH key generation script
    (pkgs.writeShellScriptBin "generate-ssh-key" (builtins.readFile ./scripts/generate_ssh_key.sh))

    # SSH connection test script
    (pkgs.writeShellScriptBin "test-ssh-connections" (builtins.readFile ./scripts/test_ssh_connections.sh))
  ];
}
