#!/usr/bin/env bash

echo "🛑 Stopping OneDrive service..."

systemctl --user stop onedrive
systemctl --user disable onedrive

if ! systemctl --user is-active --quiet onedrive; then
  echo "✅ OneDrive service stopped"
else
  echo "❌ Failed to stop OneDrive service"
fi
