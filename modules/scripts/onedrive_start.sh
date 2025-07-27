#!/usr/bin/env bash

echo "🚀 Starting OneDrive service..."

# Reload systemd user configuration
systemctl --user daemon-reload

# Enable and start the service
systemctl --user enable onedrive
systemctl --user start onedrive

if systemctl --user is-active --quiet onedrive; then
  echo "✅ OneDrive service started successfully"
  echo "🔄 OneDrive will now sync automatically in the background"
  echo ""
  echo "💡 Check status with: onedrive-status"
else
  echo "❌ Failed to start OneDrive service"
  echo "📋 Check logs with: journalctl --user -u onedrive"
fi
