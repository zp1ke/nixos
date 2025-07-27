#!/usr/bin/env bash

echo "🔄 OneDrive Reset"
echo "================="
echo "⚠️  This will stop OneDrive, remove sync state, and require re-authentication"
echo ""

read -p "Are you sure you want to reset OneDrive? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "🛑 Reset cancelled"
  exit 0
fi

echo "🛑 Stopping OneDrive service..."
systemctl --user stop onedrive 2>/dev/null || true

echo "🗑️  Removing OneDrive configuration..."
rm -rf "$HOME/.config/onedrive"
rm -rf "$HOME/.local/share/onedrive"

echo "✅ OneDrive reset complete"
echo "💡 Run 'onedrive-setup' to reconfigure OneDrive"
