#!/usr/bin/env bash

# Get current hour (24-hour format)
current_hour=$(date +%H)

# Define theme hours (adjustable)
LIGHT_START=6   # 6:00 AM
DARK_START=18   # 6:00 PM

# Apply appropriate theme based on current time
if [ $current_hour -ge $LIGHT_START ] && [ $current_hour -lt $DARK_START ]; then
    echo "Setting light theme (current time: $(date +%H:%M))"
    theme-light
else
    echo "Setting dark theme (current time: $(date +%H:%M))"
    theme-dark
fi
