# NixOS Configuration Project

## Project Purpose

This repository contains a complete NixOS configuration setup using both NixOS system configuration and Home Manager for user-specific configurations. The project provides a declarative and reproducible environment setup for a Linux desktop system.

## Project Structure

### Core Configuration Files

- **`config.nix`** - NixOS system-level configuration
  - Enables flakes and nix-command experimental features
  - Configures system packages (neovim, git, openssh, etc.)
  - Sets up Firefox, GnuPG agent, and shell preferences
  - Manages PAM services for KDE wallet integration

- **`flake.nix`** - Nix flake definition for Home Manager
  - Uses NixOS 25.05 channel
  - Defines Home Manager configuration for user `zp1ke`
  - Manages dependencies and inputs

- **`home.nix`** - Home Manager user configuration
  - User-specific package installations
  - Shell configuration (zsh with powerlevel10k theme)
  - SSH configuration and key management
  - Environment variables and dotfiles management

### Supporting Files

- **`dotfiles/`** - User dotfiles and configuration files
  - `p10k.zsh` - Powerlevel10k zsh theme configuration

- **`scripts/`** - Utility scripts
  - `make.sh` - Build and deployment script with `update` and `clean` commands
  - `setup-ssh-key.sh` - SSH key setup automation

## Format and Standards

### Nix Language
- Uses Nix expression language for all configuration files
- Follows standard Nix formatting and conventions
- Utilizes attribute sets and function definitions
- Implements let-bindings for reusable values

### File Organization
- System configuration separated from user configuration
- Dotfiles managed through Home Manager
- Scripts for automation and maintenance
- Clear separation of concerns between system and user space

### Key Features
- **Declarative Configuration**: All system and user configurations are declared in code
- **Reproducible Builds**: Flake.lock ensures consistent dependency versions
- **Home Manager Integration**: User-space package and configuration management
- **SSH/GPG Setup**: Automated SSH key management and GPG agent configuration
- **Shell Customization**: ZSH with powerlevel10k theme and useful plugins

## Usage Patterns

When working with this codebase:
1. System changes go in `config.nix`
2. User-specific changes go in `home.nix`
3. Use `scripts/make.sh update` to apply changes
4. Use `scripts/make.sh clean` for garbage collection
5. Dotfiles are managed through Home Manager file management
6. SSH and GPG configurations are automated and integrated with KDE

## Dependencies

- NixOS 25.05
- Home Manager (release-25.05)
- KDE Plasma (for wallet and SSH agent integration)
- ZSH with powerlevel10k theme
