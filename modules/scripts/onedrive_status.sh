#!/usr/bin/env bash

echo "📊 OneDrive Status"
echo "=================="

# Check if service is running
if systemctl --user is-active --quiet onedrive; then
  echo "✅ OneDrive service is running"
  echo ""
  echo "📈 Service status:"
  systemctl --user status onedrive --no-pager -l
else
  echo "❌ OneDrive service is not running"
  echo "💡 Start with: onedrive-start"
fi

echo ""
echo "📁 OneDrive directory: $HOME/OneDrive"
if [ -d "$HOME/OneDrive" ]; then
  echo "📊 Directory size: $(du -sh "$HOME/OneDrive" | cut -f1)"
  echo "📄 File count: $(find "$HOME/OneDrive" -type f | wc -l)"
else
  echo "❌ OneDrive directory not found"
fi

echo ""
echo "📋 Recent logs:"
if [ -d "$HOME/.local/share/onedrive/logs" ]; then
  ls -la "$HOME/.local/share/onedrive/logs" | tail -5
else
  echo "No logs found"
fi
