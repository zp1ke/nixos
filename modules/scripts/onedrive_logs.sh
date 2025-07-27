#!/usr/bin/env bash

echo "📋 OneDrive Logs"
echo "================"

# Show systemd logs
echo "🔍 Systemd service logs:"
journalctl --user -u onedrive -n 50 --no-pager

echo ""
echo "📁 Application logs:"
if [ -d "$HOME/.local/share/onedrive/logs" ]; then
  for log_file in "$HOME/.local/share/onedrive/logs"/*.log; do
    if [ -f "$log_file" ]; then
      echo "📄 $(basename "$log_file"):"
      tail -10 "$log_file"
      echo ""
    fi
  done
else
  echo "No application logs found"
fi
