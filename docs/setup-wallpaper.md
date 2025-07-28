# Dynamic Wallpaper Setup

This document explains how to customize the dynamic wallpaper feature that automatically changes your desktop background based on the time of day.

The setup relies on a simple configuration file in your home directory and a script that is run automatically at login and every hour.

## Customizing the Wallpaper Schedule

To change the wallpapers and their schedule, you need to edit the configuration file.

### 1. Locate and Edit the Configuration File

The configuration file is located at `~/.config/wallpaper-schedule.conf`. You can open it with any text editor.

```sh
# Example of opening with nano
nano ~/.config/wallpaper-schedule.conf
```

### 2. Understand the Format

The file uses a simple format: `HH /path/to/your/wallpaper.jpg`
- `HH`: The hour in 24-hour format (e.g., `07` for 7 AM, `18` for 6 PM).
- `/path/to/your/wallpaper.jpg`: The absolute path to the image file you want to use.

The script will select the wallpaper corresponding to the most recent hour that has passed.

Here is the default configuration:
```
# Wallpaper Schedule Configuration
#
# Format: HH /path/to/your/wallpaper.jpg
#
00 /home/zp1ke/Pictures/wallpapers/night.jpg
07 /home/-zp1ke/Pictures/wallpapers/morning.jpg
12 /home/zp1ke/Pictures/wallpapers/day.jpg
18 /home/zp1ke/Pictures/wallpapers/evening.jpg
22 /home/zp1ke/Pictures/wallpapers/night.jpg
```

### 3. Add Your Wallpapers

1.  Place your desired wallpaper images in a directory. The default location is `~/Pictures/wallpapers/`.
2.  Update the paths in `~/.config/wallpaper-schedule.conf` to point to your new images.

### 4. Apply Changes Manually

After editing the configuration file, you can test it immediately by running the following command in your terminal. This will apply the correct wallpaper for the current time without waiting for the hourly timer.

```sh
wallpaper-apply
```
