# NixOS Configuration

Personal NixOS configuration using flakes and Home Manager.

## Features

- **Flake-based configuration** for reproducible builds
- **Home Manager integration** for user environment management
- **KDE Plasma 6** desktop environment
- **Zsh** with Starship prompt and useful plugins
- **Development tools** including VS Code, Git, and CLI utilities

## Quick Start

For detailed installation instructions, see [setup.md](docs/setup.md).

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
