{ config, pkgs, ... }:

{
  # Create scripts for theme switching
  home.packages = with pkgs; [
    kdePackages.breeze
    kdePackages.plasma-desktop
    kdePackages.kconfig

    (writeShellScriptBin "theme-light"
      (builtins.replaceStrings
        ["$\{PLASMA_WORKSPACE}"]
        ["${pkgs.kdePackages.plasma-workspace}"]
        (builtins.readFile ./scripts/theme_light.sh)))

    (writeShellScriptBin "theme-dark"
      (builtins.replaceStrings
        ["$\{PLASMA_WORKSPACE}"]
        ["${pkgs.kdePackages.plasma-workspace}"]
        (builtins.readFile ./scripts/theme_dark.sh)))

    (writeShellScriptBin "theme-auto" (builtins.readFile ./scripts/theme_auto.sh))
  ];

  # Create systemd user timers for automatic switching
  systemd.user.services.theme-light = {
    Unit.Description = "Switch to light theme";
    Service = {
      Type = "oneshot";
      ExecStart = "${config.home.homeDirectory}/.nix-profile/bin/theme-light";
    };
  };

  systemd.user.timers.theme-light = {
    Unit.Description = "Timer for light theme";
    Timer = {
      OnCalendar = "*-*-* 06:30:00";
      Persistent = true;
    };
    Install.WantedBy = [ "timers.target" ];
  };

  systemd.user.services.theme-dark = {
    Unit.Description = "Switch to dark theme";
    Service = {
      Type = "oneshot";
      ExecStart = "${config.home.homeDirectory}/.nix-profile/bin/theme-dark";
    };
  };

  systemd.user.timers.theme-dark = {
    Unit.Description = "Timer for dark theme";
    Timer = {
      OnCalendar = "*-*-* 18:30:00";
      Persistent = true;
    };
    Install.WantedBy = [ "timers.target" ];
  };

  # Service to apply correct theme at login
  systemd.user.services.theme-auto = {
    enable = true;
    Unit = {
      Description = "Apply theme based on time of day";
      After = [ "plasma-workspace.target" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.writeShellScriptBin "theme-auto" (builtins.readFile ./scripts/theme_auto.sh)}/bin/theme-auto";
    };
    Install.WantedBy = [ "plasma-workspace.target" ];
  };
}
