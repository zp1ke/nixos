#!/usr/bin/env bash

CONFIG_FILE="$HOME/.config/openfortivpn/config"
CUSTOM_CONFIG="$1"

if [ -n "$CUSTOM_CONFIG" ] && [ -f "$HOME/.config/openfortivpn/$CUSTOM_CONFIG" ]; then
  CONFIG_FILE="$HOME/.config/openfortivpn/$CUSTOM_CONFIG"
  echo "🔗 Using config: $CUSTOM_CONFIG"
else
  echo "🔗 Using default config"
fi

if [ ! -f "$CONFIG_FILE" ]; then
  echo "❌ Config file not found: $CONFIG_FILE"
  echo "💡 Create a config file or specify: vpn-connect <config-name>"
  exit 1
fi

echo "🚀 Connecting to VPN..."
sudo openfortivpn -c "$CONFIG_FILE"
