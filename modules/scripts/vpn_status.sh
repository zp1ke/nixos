#!/usr/bin/env bash

if pgrep -x openfortivpn > /dev/null; then
  echo "✅ VPN is connected"
  echo "📊 Active openfortivpn processes:"
  ps aux | grep openfortivpn | grep -v grep
  echo ""
  echo "🌐 Current IP address:"
  curl -s ifconfig.me || echo "Could not get external IP"
else
  echo "❌ VPN is not connected"
fi
