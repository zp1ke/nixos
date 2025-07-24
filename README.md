# NixOS Configuration

A declarative NixOS system configuration with Home Manager integration for a complete, reproducible desktop environment setup.

## Purpose

This repository provides a complete NixOS configuration that includes:

- **System Configuration**: Core system packages, services, and settings
- **Home Manager Integration**: User-specific packages and dotfiles management
- **Desktop Environment**: KDE Plasma with integrated SSH/GPG agent support
- **Development Tools**: Neovim, Git, and essential development packages
- **Shell Customization**: ZSH with Powerlevel10k theme and useful plugins

## Features

- ✅ Declarative and reproducible configuration
- ✅ Flakes support for dependency management
- ✅ Home Manager for user-space configuration
- ✅ Automated SSH key management with KDE integration
- ✅ GPG agent with Qt pinentry
- ✅ Firefox with XDG desktop portal integration
- ✅ ZSH with Powerlevel10k theme and autosuggestions

## Initial Setup

### Prerequisites

- Fresh NixOS installation
- Internet connection
- Git installed (should be available by default)

### Step 1: Clone the Repository

```bash
git clone https://github.com/zp1ke/nixos.git
cd nixos
```

### Step 2: Modify System Configuration

Edit your system configuration file to include this repository's configuration:

```bash
sudo nano /etc/nixos/configuration.nix
```

Add the following line to import the configuration from this repository:

```nix
{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    /path/to/your/nixos/config.nix  # Add this line
  ];

  # Your existing configuration...
}
```

Replace `/path/to/your/nixos/config.nix` with the actual path where you cloned this repository.

### Step 3: Apply System Configuration

Apply the system configuration:

```bash
# Navigate to the repository directory
cd /path/to/your/nixos
./scrips/make.sh update
```

This command will:
1. Copy the configuration to `/etc/nixos/`
2. Rebuild the NixOS system
3. Apply Home Manager changes

### Step 5: Setup SSH Keys

Run the setup script:

```bash
./scripts/setup-ssh-key.sh
```

### Cleaning Up

Remove unused packages and generations:

```bash
./scripts/make.sh clean
```

## Configuration Files

- **`config.nix`** - System-level NixOS configuration
- **`home.nix`** - User-specific Home Manager configuration
- **`flake.nix`** - Flake definition with dependencies
- **`flake.lock`** - Lock file ensuring reproducible builds
- **`dotfiles/`** - User dotfiles managed by Home Manager
- **`scripts/`** - Utility scripts for maintenance

## Troubleshooting

### Home Manager Issues

If Home Manager fails to apply:

```bash
# Remove existing Home Manager generation
rm ~/.local/state/nix/profiles/home-manager*

# Reapply configuration
home-manager switch --flake .#zp1ke
```

### System Configuration Issues

If system rebuild fails:

```bash
# Check configuration syntax
sudo nixos-rebuild dry-build

# View detailed error messages
sudo nixos-rebuild switch --show-trace
```

## License

This configuration is provided under the MIT License. See [LICENSE](LICENSE) for details.
