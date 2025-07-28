#!/usr/bin/env bash

# Get current hour (24-hour format)
current_hour=$(date +%H)

# Define theme hours (adjustable)
LIGHT_START_HOUR=6
LIGHT_START_MIN=30
DARK_START_HOUR=18
DARK_START_MIN=30

current_hour=$(date +%H)
current_min=$(date +%M)

# Apply appropriate theme based on current time
if { [ "$current_hour" -gt "$LIGHT_START_HOUR" ] || { [ "$current_hour" -eq "$LIGHT_START_HOUR" ] && [ "$current_min" -ge "$LIGHT_START_MIN" ]; }; } && \
   { [ "$current_hour" -lt "$DARK_START_HOUR" ] || { [ "$current_hour" -eq "$DARK_START_HOUR" ] && [ "$current_min" -lt "$DARK_START_MIN" ]; }; }
then
    echo "Setting light theme (current time: $(date +%H:%M))"
    theme-light
else
    echo "Setting dark theme (current time: $(date +%H:%M))"
    theme-dark
fi
