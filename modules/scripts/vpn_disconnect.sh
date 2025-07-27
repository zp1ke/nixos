#!/usr/bin/env bash

echo "🔌 Disconnecting VPN..."
sudo pkill openfortivpn

if [ $? -eq 0 ]; then
  echo "✅ VPN disconnected"
else
  echo "❌ No VPN connection found"
fi
