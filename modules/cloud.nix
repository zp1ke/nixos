{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    onedrive
    rclone       # Alternative cloud sync tool

    # OneDrive management scripts
    (writeShellScriptBin "onedrive-setup" (builtins.readFile ./scripts/onedrive_setup.sh))
    (writeShellScriptBin "onedrive-sync" (builtins.readFile ./scripts/onedrive_sync.sh))
    (writeShellScriptBin "onedrive-monitor" (builtins.readFile ./scripts/onedrive_monitor.sh))
    (writeShellScriptBin "onedrive-status" (builtins.readFile ./scripts/onedrive_status.sh))
    (writeShellScriptBin "onedrive-start" (builtins.readFile ./scripts/onedrive_start.sh))
    (writeShellScriptBin "onedrive-stop" (builtins.readFile ./scripts/onedrive_stop.sh))
    (writeShellScriptBin "onedrive-logs" (builtins.readFile ./scripts/onedrive_logs.sh))
    (writeShellScriptBin "onedrive-reset" (builtins.readFile ./scripts/onedrive_reset.sh))
  ];

  # OneDrive service configuration
  systemd.user.services.onedrive = {
    Unit = {
      Description = "OneDrive sync service";
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.onedrive}/bin/onedrive --monitor";
      ExecStartPre = "${pkgs.onedrive}/bin/onedrive --synchronize";
      Restart = "on-failure";
      RestartSec = "3";
      RestartPreventExitStatus = "3";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  # OneDrive configuration files
  home.file.".config/onedrive/config" = {
    text = ''
      # OneDrive Client Configuration

      # Directory where the OneDrive files will be stored
      sync_dir = "~/OneDrive"

      # Skip files and directories that match this pattern
      skip_file = "~*|.~*|*.tmp|*.swp|.DS_Store|.localized|desktop.ini"

      # Skip directories that match this pattern
      skip_dir = ".git|.vscode|node_modules|__pycache__|.cache"

      # Enable logging
      log_dir = "~/.local/share/onedrive/logs"

      # Upload only - set to true to upload local changes only
      upload_only = false

      # Download only - set to true to download remote changes only
      download_only = false

      # Check for nosync file - if present, skip that directory
      check_nosync = true

      # Classify as big file if size is greater than this value (in bytes)
      classify_as_big_file = 52428800

      # Sync business shared folders
      sync_business_shared_folders = false

      # Application notification
      enable_notification = true

      # Webhook notification on file changes
      webhook_enabled = false
    '';
  };
}
