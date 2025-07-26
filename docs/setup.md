# NixOS Installation Setup Guide

This guide provides step-by-step instructions for installing NixOS using the minimal ISO with this flake-based configuration.

## Prerequisites

- NixOS minimal ISO (download from [nixos.org](https://nixos.org/download.html))
- USB drive (8GB minimum)
- Target machine (the configuration is set up for a host named "legion")

## Step 1: Boot from NixOS Minimal ISO

1. Create a bootable USB drive with the NixOS minimal ISO
2. Boot your target machine from the USB drive
3. You should see the NixOS installer prompt

## Step 2: Initial Setup and Networking

1. **Set up network connection:**
   ```sh
   # Test connectivity
   ping google.com
   ```

2. **Enable experimental features temporarily:**
   ```sh
   mkdir -p ~/.config/nix
   echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
   ```

## Step 3: Disk Partitioning

**⚠️ WARNING: This will erase all data on your target disk!**

1. **Identify your target disk:**
   ```sh
   lsblk
   # Look for your target disk (e.g., /dev/sda, /dev/nvme0n1, etc.)
   ```

2. **Partition the disk (adjust device name as needed):**
   ```sh
   # Replace /dev/sda with your actual disk
   sudo fdisk /dev/sda

   # Create partitions:
   # - Boot partition (512MB, type EFI System)
   # - Root partition (remaining space, type Linux filesystem)

   # Example fdisk commands:
   # g (create GPT partition table)
   # n (new partition) -> 1 -> default start -> +512M
   # t (change type) -> 1 (EFI System)
   # n (new partition) -> 2 -> default start -> default end
   # w (write changes)
   ```

3. **Format the partitions:**
   ```sh
   # Format boot partition (EFI)
   sudo mkfs.fat -F 32 /dev/sda1

   # Format root partition
   sudo mkfs.ext4 /dev/sda2
   ```

4. **Mount the partitions:**
   ```sh
   # Mount root
   sudo mount /dev/sda2 /mnt

   # Create and mount boot directory
   sudo mkdir -p /mnt/boot
   sudo mount /dev/sda1 /mnt/boot
   ```

## Step 4: Generate Hardware Configuration

1. **Generate hardware configuration:**
   ```sh
   sudo nixos-generate-config --root /mnt
   ```

2. **This creates `/mnt/etc/nixos/hardware-configuration.nix` - we'll use this later**

## Step 5: Clone and Setup Configuration

1. **Install git temporarily:**
   ```sh
   nix-shell -p git
   ```

2. **Clone this repository:**
   ```sh
   cd /mnt
   git clone https://github.com/zp1ke/nixos.git nixos-config
   cd nixos-config
   ```

3. **Copy the generated hardware configuration:**
   ```sh
   sudo cp /mnt/etc/nixos/hardware-configuration.nix /mnt/nixos-config/hosts/legion/
   # Stage the file so flake can see it
   git add hosts/legion/hardware-configuration.nix
   ```

4. **Review and adjust the hardware configuration if needed:**
   ```sh
   sudo nano hosts/legion/hardware-configuration.nix
   ```

## Step 6: Customize Configuration (Optional)

Before installation, you may want to customize some settings:

1. **Edit hostname (if different from "legion"):**
   ```sh
   sudo nano hosts/legion/configuration.nix
   # Change the hostName in networking section
   ```

2. **Edit user configuration:**
   ```sh
   sudo nano home-manager/zp1ke.nix
   # Update username, email, or other personal settings
   ```

3. **Review boot loader settings:**
   ```sh
   sudo nano hosts/legion/configuration.nix
   ```

## Step 7: Install NixOS

1. **Install the system:**
   ```sh
   sudo nixos-install --flake .#legion
   ```

   This command will:
   - Download and build all necessary packages
   - Install the base system
   - Set up Home Manager for user `zp1ke`
   - Configure all services

2. **Set root password when prompted:**
   You'll be asked to set a password for the root user

3. **Set user password:**
   ```sh
   sudo nixos-enter --root /mnt
   passwd zp1ke
   exit
   ```

## Step 8: First Boot

1. **Reboot into the new system:**
   ```sh
   sudo reboot
   # Remove the USB drive when prompted
   ```

2. **Login with your user account (zp1ke)**

3. **Verify the installation:**
   ```sh
   # Verify flakes are working
   nix --version

   # Check Home Manager
   home-manager --version

   # Test zsh aliases (enhanced CLI tools)
   ll        # Enhanced ls with eza
   cat       # Enhanced cat with bat (syntax highlighting)
   ```

## Step 9: Locate Configuration

1. **Find your configuration:**
   ```sh
   ls -la /nixos-config
   ```

2. **Move to standard location:**
   ```sh
   sudo mv /nixos-config/** /etc/nixos
   sudo mv /nixos-config/.git* /etc/nixos
   cd /etc/nixos
   # If owned by root, change to your user
   sudo chown -R zp1ke:users /etc/nixos
   ```

3. **Set up for future updates:**
   ```sh
   # Make updates with convenient alias
   nixos-update    # Updates system configuration

   # Or manually:
   sudo nixos-rebuild switch --flake .#legion
   ```

## Step 10: Post-Installation

1. **Update the system:**
   ```sh
   nixos-update    # Convenient alias for system updates

   # Or manually:
   sudo nixos-rebuild switch --flake .#legion
   ```

2. **Update flake inputs (optional):**
   ```sh
   cd /etc/nixos
   sudo nix flake update
   nixos-update    # Apply updates with alias
   ```

## Configuration Overview

This NixOS configuration includes:

### System Features
- **Desktop Environment**: KDE Plasma 6 with SDDM display manager
- **Audio**: PipeWire (replaces PulseAudio)
- **Shell**: Zsh with Starship prompt
- **Boot**: GRUB with OS-Prober for dual boot
- **Network**: NetworkManager
- **Services**: SSH, CUPS printing, firewall

### User Environment (Home Manager)
- **Applications**: Firefox, VS Code, development tools
- **Shell**: Zsh with plugins and enhanced aliases:
  - `ll` - Enhanced directory listing with eza
  - `cat` - Syntax-highlighted file viewing with bat
  - `grep` - Faster searching with ripgrep
  - `..` and `...` - Quick directory navigation
- **Terminal**: Enhanced with Starship prompt and history search
- **Utilities**: bat, eza, ripgrep for enhanced CLI experience

### File Structure
```
/
├── flake.nix              # Main flake configuration
├── hosts/
│   └── legion/
│       ├── configuration.nix      # Host-specific system config
│       └── hardware-configuration.nix  # Hardware-specific config
├── home-manager/
│   └── zp1ke.nix         # User-specific Home Manager config
└── modules/
    └── base.nix          # Shared system modules
```

## Troubleshooting

### Common Issues

1. **Boot loader installation fails:**
   - Verify the disk device in `configuration.nix` matches your actual disk
   - Ensure EFI partition is properly formatted and mounted

2. **Network issues after installation:**
   - Check NetworkManager service: `systemctl status NetworkManager`
   - Try: `sudo systemctl restart NetworkManager`

3. **Flake not found error:**
   - Ensure you're in the correct directory
   - Verify the flake.nix file exists and is valid: `nix flake check`

4. **Permission issues:**
   - Make sure the user is in the correct groups (wheel, networkmanager)
   - Check: `groups zp1ke`

### Getting Help

- **NixOS Manual**: https://nixos.org/manual/nixos/stable/
- **Home Manager Options**: https://nix-community.github.io/home-manager/options.xhtml
- **NixOS Discourse**: https://discourse.nixos.org/
- **NixOS Wiki**: https://nixos.wiki/

## Making Changes

To modify your system after installation:

1. **Edit configuration files in `/etc/nixos/`**
2. **Test changes:** `sudo nixos-rebuild test --flake .#legion`
3. **Apply permanently:** `nixos-update` or `sudo nixos-rebuild switch --flake .#legion`

For Home Manager changes:
1. **Edit the user config**
2. **Apply changes:** `home-manager switch --flake .#zp1ke`

### Enhanced Terminal Experience

After installation, you'll have access to enhanced terminal tools:

- **Directory navigation:**
  - `ll` - Beautiful file listing with icons and colors

- **File viewing and searching:**
  - `cat filename` - Syntax-highlighted file viewing
  - `grep pattern` - Fast searching with ripgrep
  - Use `Ctrl+R` for history search
  - Use arrow keys for smart history navigation

- **System management:**
  - `nixos-update` - Quick system updates

---

**Note**: This configuration is tailored for the "legion" host. If you're installing on a different machine, you may need to create a new host configuration or modify the existing one accordingly.
