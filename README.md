# NixOS Configuration

Personal NixOS configuration using flakes and Home Manager.

## Features

- **Flake-based configuration** for reproducible builds
- **Home Manager integration** for user environment management
- **KDE Plasma 6** desktop environment
- **Zsh** with Starship prompt and useful plugins
- **Development tools** including VS Code, Git, Docker, and CLI utilities
- **Dynamic Wallpaper** that changes based on the time of day
- **Per-project environments** with direnv for managing JDK versions
- **SSH key management** with convenient scripts
- **Enhanced terminal** with aliases and modern CLI tools (eza, bat, ripgrep)
- **VPN support** with OpenFortiVPN integration
- **OneDrive integration** with automatic sync capabilities

## Quick Start

1. **System Installation**: For detailed installation instructions, see [setup.md](docs/setup.md)
2. **Development Environment**: Set up per-project environments with [setup-development.md](docs/setup-development.md)
3. **Dynamic Wallpaper**: Customize your desktop wallpaper with [setup-wallpaper.md](docs/setup-wallpaper.md)
4. **Git & SSH Setup**: After installation, configure Git and SSH keys with [setup-git.md](docs/setup-git.md)
5. **Network & VPN**: Configure VPN connections with [setup-network.md](docs/setup-network.md)
6. **Cloud Storage**: Set up OneDrive sync with [setup-cloud.md](docs/setup-cloud.md)

## Structure

```
├── flake.nix                          # Main flake configuration
├── docs/
│   ├── setup.md                       # Installation guide
│   ├── setup-development.md           # Development environment setup guide
│   ├── setup-wallpaper.md             # Dynamic wallpaper setup guide
│   ├── setup-git.md                   # Git & SSH setup guide
│   ├── setup-network.md               # Network & VPN setup guide
│   └── setup-cloud.md                 # Cloud storage setup guide
├── hosts/
│   └── legion/
│       └── configuration.nix          # Host-specific system config
├── home-manager/
│   └── zp1ke.nix                      # User configuration
├── modules/
│   ├── base.nix                       # Shared system modules
│   ├── development.nix                # Development tools and environment
│   ├── git.nix                        # Git configuration
│   ├── ssh.nix                        # SSH configuration
│   ├── terminal.nix                   # Terminal & Zsh setup
│   ├── theme.nix                      # Auto theme configuration
│   ├── wallpaper.nix                  # Dynamic wallpaper configuration
│   ├── network.nix                    # Network & VPN configuration
│   ├── cloud.nix                      # Cloud storage configuration
│   └── scripts/
│       ├── generate_ssh_key.sh        # SSH key generation
│       ├── test_ssh_connections.sh    # SSH connection test
│       ├── vpn_*.sh                   # VPN management scripts
│       ├── onedrive_*.sh              # OneDrive management scripts
│       ├── theme_*.sh                 # Theme management scripts
│       └── wallpaper_apply.sh         # Wallpaper management script
├── overlays/                          # Nix package overlays
└── secrets/                           # Secrets (gitignored)
```

## License

MIT License - see [LICENSE](LICENSE) for details.
