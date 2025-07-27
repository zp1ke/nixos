#!/usr/bin/env bash

echo "🔧 VPN Setup Helper"
echo "=================="

CONFIG_NAME="$1"
if [ -z "$CONFIG_NAME" ]; then
  CONFIG_NAME="config"
fi

CONFIG_DIR="$HOME/.config/openfortivpn"
CONFIG_FILE="$CONFIG_DIR/$CONFIG_NAME"

mkdir -p "$CONFIG_DIR"

if [ -f "$CONFIG_FILE" ]; then
  echo "⚠️  Config file already exists: $CONFIG_FILE"
  read -p "Do you want to overwrite it? (y/N): " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "🛑 Setup cancelled"
    exit 0
  fi
fi

echo "📝 Creating VPN configuration..."
echo ""

read -p "VPN Host (e.g., vpn.company.com): " VPN_HOST
read -p "VPN Port (default 443): " VPN_PORT
VPN_PORT=${VPN_PORT:-443}
read -p "Username: " VPN_USERNAME
read -s -p "Password: " VPN_PASSWORD
echo ""
read -p "Realm (optional): " VPN_REALM

cat > "$CONFIG_FILE" << EOF
# OpenFortiVPN Configuration
host = $VPN_HOST
port = $VPN_PORT
username = $VPN_USERNAME
password = $VPN_PASSWORD
EOF

if [ -n "$VPN_REALM" ]; then
  echo "realm = $VPN_REALM" >> "$CONFIG_FILE"
fi

cat >> "$CONFIG_FILE" << EOF

# Security and routing options
set-routes = 1
set-dns = 1
pppd-use-peerdns = 1

# Uncomment and configure if needed:
# trusted-cert = <certificate_fingerprint>
# user-cert = /path/to/client.crt
# user-key = /path/to/client.key
# ca-file = /path/to/ca.crt
EOF

chmod 600 "$CONFIG_FILE"

echo ""
echo "✅ VPN configuration created: $CONFIG_FILE"
echo ""
echo "📋 Available commands:"
echo "  vpn-connect [$CONFIG_NAME]  # Connect to VPN"
echo "  vpn-disconnect             # Disconnect VPN"
echo "  vpn-status                 # Check VPN status"
echo ""
echo "🔐 Security note: Config file permissions set to 600 (user read/write only)"

if [ "$CONFIG_NAME" != "config" ]; then
  echo "💡 To use this config: vpn-connect $CONFIG_NAME"
else
  echo "💡 To connect: vpn-connect"
fi
