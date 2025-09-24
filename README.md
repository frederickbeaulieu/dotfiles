# Dotfiles 

My macOS configuration backup and deployment system

## Description

This project enables syncing applications and configurations across computers easily using Homebrew, Stow, and automated backups. It includes configurations for:

- **Terminal**: Zsh with Starship prompt, syntax highlighting, and autosuggestions
- **Editors**: Neovim (LazyVim) and VS Code with extensive plugins
- **Window Management**: AeroSpace tiling window manager
- **Status Bar**: SketchyBar with custom plugins
- **File Management**: Yazi terminal file manager
- **Development Tools**: Docker, Git, Node.js, Go, Java, Python, and more

## Features

- 🍺 Automated Homebrew package installation (70+ packages)
- 🔗 Symlink management with GNU Stow
- 📱 Mac App Store application installation
- 🔄 Automatic configuration backups
- ⚡ One-command setup for new machines

## Getting Started

### Prerequisites

- macOS (tested on latest versions)
- Internet connection for downloads

### Quick Installation

Clone the repository to your home directory:

```bash
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### Setup Options

#### Full Setup (Recommended)
Install everything and symlink configurations:
```bash
make
```

#### Step-by-Step Setup

1. **Install dependencies only:**
   ```bash
   make init
   ```

2. **Preview what files will be overwritten:**
   ```bash
   make stow_test_override
   ```

3. **Symlink configurations (with backup):**
   ```bash
   make stow_override
   ```

4. **Create backup of current configs:**
   ```bash
   make backup
   ```

## What Gets Installed

### Command Line Tools
- `bat`, `fd`, `fzf`, `ripgrep`, `yazi` - Enhanced file operations
- `lazygit`, `git-lfs` - Git workflow tools
- `btop`, `tree-sitter-cli` - System monitoring and parsing
- `starship`, `zoxide` - Shell enhancements

### Development Environment
- **Languages**: Node.js, Go, Python, Java, Rust
- **Editors**: Neovim, VS Code with 50+ extensions
- **Tools**: Docker, Firebase CLI, Maven, Gradle
- **Databases**: SQL tools and formatters

### macOS Applications
- **Productivity**: Bitwarden, CleanShot, BetterDisplay
- **Development**: Ghostty, Android Studio, Xcode, Postman, Bruno
- **Communication**: Discord, Slack, Signal
- **System**: AeroSpace, WireGuard, Amphetamine

### Configurations Managed
- `.zshrc` - Zsh shell configuration
- `.aerospace.toml` - Window manager settings  
- `.config/nvim/` - Neovim LazyVim setup
- `.config/sketchybar/` - Status bar configuration
- `.config/yazi/` - File manager settings
- `.config/ghostty/` - Terminal emulator config

## Backup System

Configurations are automatically backed up to `~/.dotfiles/backup/` with timestamps before any changes. The system backs up:

- Existing dotfiles before symlinking
- Current Homebrew bundle state
- All `.config` directory contents

## Customization

1. **Modify package lists**: Edit `Brewfile` to add/remove applications
2. **Add configurations**: Place config files in `files/.config/`
3. **Update dotfiles list**: Modify `DOTFILES` variable in `Makefile`
4. **Customize shell**: Edit `files/.zshrc`

## Troubleshooting

### Common Issues

- **Permission errors**: Ensure you have admin privileges
- **Homebrew conflicts**: Run `brew doctor` to diagnose issues
- **Stow conflicts**: Use `make stow_test_override` to preview changes

### Manual Recovery

If something goes wrong, restore from the latest backup:
```bash
# Backups are stored in ~/.dotfiles/backup/ with timestamps
ls ~/.dotfiles/backup/
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Test changes on a clean macOS installation
4. Submit a pull request

## License

This project is open source and available under the [MIT License](LICENSE).
