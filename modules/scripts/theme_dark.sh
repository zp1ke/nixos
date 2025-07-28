#!/usr/bin/env bash

# Apply KDE Plasma dark theme
${PLASMA_WORKSPACE}/bin/plasma-apply-colorscheme BreezeDark 2>/dev/null
lookandfeeltool -a org.kde.breezedark.desktop 2>/dev/null

for profile in ~/.local/share/konsole/*.profile; do
  if [ -f "$profile" ]; then
    kwriteconfig6 --file "$profile" --group Appearance --key ColorScheme "Breeze"
  fi
done
