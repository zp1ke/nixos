# NixOS Configuration

Personal NixOS configuration using flakes and Home Manager.

## Features

- **Flake-based configuration** for reproducible builds
- **Home Manager integration** for user environment management
- **KDE Plasma 6** desktop environment
- **Zsh** with Starship prompt and useful plugins
- **Development tools** including VS Code, Git, and CLI utilities
- **SSH key management** with convenient scripts
- **Enhanced terminal** with aliases and modern CLI tools (eza, bat, ripgrep)

## Quick Start

1. **System Installation**: For detailed installation instructions, see [setup.md](docs/setup.md)
2. **Git & SSH Setup**: After installation, configure Git and SSH keys with [setup-git.md](docs/setup-git.md)

## Structure

```
├── flake.nix                        # Main flake configuration
├── docs/
│   ├── setup.md                     # Installation guide
│   └── setup-git.md                 # Git & SSH setup guide
├── hosts/
│   └── legion/
│       └── configuration.nix        # Host-specific system config
├── home-manager/
│   └── zp1ke.nix                    # User configuration
├── modules/
│   ├── base.nix                     # Shared system modules
│   ├── git.nix                      # Git configuration
│   ├── ssh.nix                      # SSH configuration
│   ├── terminal.nix                 # Terminal & Zsh setup
│   └── scripts/
│       ├── generate_ssh_key.sh      # SSH key generation script
│       └── test_ssh_connections.sh  # SSH connection test
├── overlays/                        # Nix package overlays
└── secrets/                         # Secrets (gitignored)
```

## License

MIT License - see [LICENSE](LICENSE) for details.
