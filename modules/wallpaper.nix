{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    (writeShellScriptBin "wallpaper-apply" (builtins.readFile ./scripts/wallpaper_apply.sh))
  ];

  # Create the systemd service that runs the script
  systemd.user.services.wallpaper-apply = {
    Unit = {
      Description = "Apply wallpaper based on time of day";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${config.home.homeDirectory}/.nix-profile/bin/wallpaper-apply";
    };
  };

  # Create the hourly timer to trigger the service
  systemd.user.timers.wallpaper-apply = {
    Unit = {
      Description = "Hourly timer to check and apply wallpaper";
    };
    Timer = {
      OnCalendar = "hourly"; # Runs at the start of every hour
      Persistent = true;
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };

  # Create a service to run the script on login
  systemd.user.services.wallpaper-apply-on-login = {
    Unit = {
      Description = "Apply wallpaper on login";
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${config.home.homeDirectory}/.nix-profile/bin/wallpaper-apply";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  # Create the default wallpaper schedule configuration file
  home.file.".config/wallpaper-schedule.conf".text = ''
    # Wallpaper Schedule Configuration
    #
    # Format: HH /path/to/your/wallpaper.jpg
    # - HH is the hour in 24-hour format (00-23).
    # - The script will use the wallpaper for the latest hour that is not in the future.
    # - Make sure to use absolute paths to your wallpapers.
    #
    # Example:
    00 /home/zp1ke/Pictures/wallpapers/night.jpg
    07 /home/zp1ke/Pictures/wallpapers/morning.jpg
    12 /home/zp1ke/Pictures/wallpapers/day.jpg
    18 /home/zp1ke/Pictures/wallpapers/evening.jpg
    22 /home/zp1ke/Pictures/wallpapers/night.jpg
  '';
}
