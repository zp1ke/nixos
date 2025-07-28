#!/usr/bin/env bash

# Apply KDE Plasma light theme
${PLASMA_WORKSPACE}/bin/plasma-apply-colorscheme BreezeLight 2>/dev/null
lookandfeeltool -a org.kde.breeze.desktop 2>/dev/null

for profile in ~/.local/share/konsole/*.profile; do
  if [ -f "$profile" ]; then
    kwriteconfig6 --file "$profile" --group Appearance --key ColorScheme "BlackOnWhite"
  fi
done
