# Network & VPN Setup Guide

Quick reference for configuring VPN connections with OpenFortiVPN.

## Prerequisites

- Completed NixOS installation
- Network connectivity
- VPN server details (host, username, password)

## Setup Steps

### 1. Configure VPN

```bash
# Run the interactive setup wizard
vpn-setup

# Or create a named configuration for multiple VPNs
vpn-setup work-vpn
vpn-setup home-office
```

### 2. Connect to VPN

```bash
# Connect using default config
vpn-connect

# Connect using specific config
vpn-connect work-vpn
```

### 3. Manage VPN Connection

```bash
# Check connection status
vpn-status

# Disconnect from VPN
vpn-disconnect
```

## Available Commands

| Command | Description |
|---------|-------------|
| `vpn-setup [name]` | Interactive VPN configuration setup |
| `vpn-connect [name]` | Connect to VPN (optionally specify config) |
| `vpn-disconnect` | Disconnect from active VPN |
| `vpn-status` | Show VPN connection status and IP |

## Configuration Files

- **Default config**: `~/.config/openfortivpn/config`
- **Named configs**: `~/.config/openfortivpn/{name}`

## Common VPN Settings

When running `vpn-setup`, you'll need:

- **VPN Host**: e.g., `vpn.company.com`
- **Port**: Usually `443` (default)
- **Username**: Your VPN username
- **Password**: Your VPN password
- **Realm**: Optional, ask your IT admin

## Multiple VPN Configurations

```bash
# Set up different VPNs
vpn-setup work
vpn-setup client-a
vpn-setup client-b

# Connect to specific VPN
vpn-connect work
vpn-connect client-a
```

## Troubleshooting

### Connection Issues
```bash
# Check VPN status
vpn-status

# View detailed connection attempt
vpn-connect work  # Shows verbose output
```

### Reset Configuration
```bash
# Remove specific config
rm ~/.config/openfortivpn/work-vpn

# Reconfigure
vpn-setup work-vpn
```

### Common Problems

1. **Certificate errors**: Add `trusted-cert` to config file
2. **Authentication failures**: Verify username/password
3. **Connection timeouts**: Check host and port settings
4. **DNS issues**: VPN automatically configures DNS

---

**Note**: VPN configurations are stored with restricted permissions (600) for security.
