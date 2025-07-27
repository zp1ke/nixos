#!/usr/bin/env bash

echo "🔧 OneDrive Setup"
echo "================"

# Create OneDrive directory
ONEDRIVE_DIR="$HOME/OneDrive"
mkdir -p "$ONEDRIVE_DIR"
echo "📁 Created OneDrive directory: $ONEDRIVE_DIR"

# Create logs directory
mkdir -p "$HOME/.local/share/onedrive/logs"

echo ""
echo "🔐 Starting OneDrive authentication..."
echo "This will open a browser window for Microsoft authentication."
echo ""

# Authenticate with OneDrive
onedrive --auth

if [ $? -eq 0 ]; then
  echo ""
  echo "✅ OneDrive authentication successful!"
  echo ""
  echo "📋 Available commands:"
  echo "  onedrive-sync       # Start manual sync"
  echo "  onedrive-monitor    # Start monitoring mode"
  echo "  onedrive-status     # Check sync status"
  echo "  onedrive-start      # Start systemd service"
  echo "  onedrive-stop       # Stop systemd service"
  echo ""
  echo "🚀 To enable automatic sync, run: onedrive-start"
else
  echo "❌ OneDrive authentication failed"
  exit 1
fi
