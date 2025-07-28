#!/usr/bin/env bash

CONFIG_FILE="$HOME/.config/wallpaper-schedule.conf"

if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "Configuration file not found: $CONFIG_FILE"
    exit 1
fi

# Get the current hour (e.g., 09, 18)
current_hour=$(date +%H)

# Find the most recent wallpaper for the current time
# 1. Grep lines that start with a number (the hour).
# 2. Filter for hours less than or equal to the current hour.
# 3. Sort them numerically to get the latest hour at the bottom.
# 4. Take the last line.
# 5. Cut out the wallpaper path (the second field onwards).
wallpaper_path=$(grep '^[0-9][0-9]' "$CONFIG_FILE" | awk -v hour="$current_hour" '$1 <= hour' | sort -n | tail -n 1 | cut -d' ' -f2-)

if [[ -z "$wallpaper_path" ]]; then
    echo "No suitable wallpaper found for the current hour ($current_hour)."
    # Fallback to the first wallpaper in the list if no match is found (e.g., for early morning hours)
    wallpaper_path=$(grep '^[0-9][0-9]' "$CONFIG_FILE" | sort -n | tail -n 1 | cut -d' ' -f2-)
    if [[ -z "$wallpaper_path" ]]; then
      echo "No wallpapers defined in config."
      exit 1
    fi
fi

echo "Setting wallpaper to: $wallpaper_path"

# Use qdbus to set the wallpaper for all activities and desktops in Plasma 6
qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "
var allDesktops = desktops();
for (i=0;i<allDesktops.length;i++) {
    d = allDesktops[i];
    d.wallpaperPlugin = 'org.kde.image';
    d.currentConfigGroup = Array('Wallpaper', 'org.kde.image', 'General');
    d.writeConfig('Image', 'file://${wallpaper_path}');
}
"
