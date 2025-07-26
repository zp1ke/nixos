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
├── flake.nix              # Main flake configuration
├── hosts/
│   └── legion/            # Host-specific configuration
├── home-manager/
│   └── zp1ke.nix         # User configuration
└── modules/
    └── base.nix          # Shared modules
```

## License

MIT License - see [LICENSE](LICENSE) for details.
