# Cloud Storage Setup Guide

Quick reference for setting up OneDrive synchronization.

## Prerequisites

- Completed NixOS installation
- Microsoft account with OneDrive access
- Internet connectivity

## Setup Steps

### 1. Initial Setup

```bash
# Run the setup wizard (opens browser for authentication)
onedrive-setup
```

This will:
- Create `~/OneDrive` directory
- Open browser for Microsoft authentication
- Configure initial sync settings

### 2. Start Automatic Sync

```bash
# Enable background sync service
onedrive-start
```

### 3. Verify Setup

```bash
# Check sync status and service
onedrive-status
```

## Available Commands

| Command | Description |
|---------|-------------|
| `onedrive-setup` | Initial setup and authentication |
| `onedrive-start` | Start automatic background sync |
| `onedrive-stop` | Stop automatic sync service |
| `onedrive-sync` | Manual one-time sync |
| `onedrive-monitor` | Interactive monitoring mode |
| `onedrive-status` | Show sync status and statistics |
| `onedrive-logs` | View detailed sync logs |
| `onedrive-reset` | Complete reset (requires re-authentication) |

## Directory Structure

- **Sync folder**: `~/OneDrive/`
- **Configuration**: `~/.config/onedrive/`
- **Logs**: `~/.local/share/onedrive/logs/`

## Daily Usage

### Check Sync Status
```bash
onedrive-status
```

### Manual Sync (if needed)
```bash
onedrive-sync
```

### View Recent Activity
```bash
onedrive-logs
```

## Configuration

The default configuration excludes:
- Temporary files (`*.tmp`, `*.swp`)
- System files (`.DS_Store`, `desktop.ini`)
- Development folders (`.git`, `node_modules`, `__pycache__`)

To modify sync patterns, edit: `~/.config/onedrive/config`

## Troubleshooting

### Sync Issues
```bash
# Check detailed status
onedrive-status

# View logs for errors
onedrive-logs

# Manual sync with verbose output
onedrive-sync
```

### Authentication Problems
```bash
# Reset and reconfigure
onedrive-reset
onedrive-setup
```

### Service Not Starting
```bash
# Check service status
systemctl --user status onedrive

# Restart service
onedrive-stop
onedrive-start
```

### Common Issues

1. **Authentication expired**: Run `onedrive-setup` again
2. **Sync conflicts**: Check logs and resolve manually
3. **Large files**: May take time to upload/download
4. **Network interruption**: Service auto-restarts when connection returns

## Security Notes

- Config files have restricted permissions (600)
- Passwords stored locally in config file
- Service runs only for your user account
- Sync state preserved across system rebuilds

---

**Note**: OneDrive service runs automatically in background after `onedrive-start`. Use `onedrive-status` to monitor sync activity.
