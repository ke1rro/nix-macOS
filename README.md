# Nix Configuration for macOS (Separated Setup)

This configuration provides a **completely separated** setup with nix-darwin for system configuration and standalone Home Manager for user configuration.

## Table of Contents

- [Important Notes](#important-notes)
- [Architecture](#architecture)
- [Initial Setup](#initial-setup)
  - [Prerequisites](#prerequisites)
  - [Configuration Setup](#configuration-setup)
- [Package Distribution](#package-distribution)
  - [System Level (`darwin/configuration.nix`)](#system-level-darwinconfigurationnix)
  - [User Level (`home/home.nix`)](#user-level-homehomenix)
- [Usage](#usage)
  - [System Configuration Changes](#system-configuration-changes)
  - [User Configuration Changes](#user-configuration-changes)
  - [Available Home Manager Commands](#available-home-manager-commands)
- [Testing Your Setup](#testing-your-setup)
- [Shell Configuration](#shell-configuration)
- [Directory Structure](#directory-structure)
  - [Wezterm Configuration Setup](#wezterm-configuration-setup)
  - [Wezterm Shortcuts](#wezterm-shortcuts)
- [Dev Shells](#dev-shells)
  - [Java Development Shell](#java-development-shell)
  - [C++ Development Shell](#c-development-shell)
- [Separated Setup Migration Instructions](#separated-setup-migration-instructions)

## Important Notes

> [!IMPORTANT]
> This configuration uses nixpkgs-unstable. For production use, consider using stable channels.

> [!IMPORTANT]
> The setup is optimized for zsh. If using a different shell, adjust configurations accordingly.

> [!WARNING]
> Always test changes in a non-production environment first.

## Architecture

- **System Configuration**: Managed by nix-darwin (`darwin/configuration.nix`)
- **User Configuration**: Managed by standalone Home Manager (`home/home.nix`)
- **Complete Independence**: System and user configurations can be updated separately

## Initial Setup

### Prerequisites

1. Install Nix with flakes support:

```bash
mkdir -p ~/.config/nix
echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf
```

2. Install nix-darwin:

```bash
nix run nix-darwin --extra-experimental-features nix-command --extra-experimental-features flakes -- switch --flake ~/nix-config
```

### Configuration Setup

1. **Update usernames and hostnames in configuration files:**

```bash
# Get your username
whoami

# Get your hostname
hostname

# Get your home directory
echo $HOME
```

2. **Edit `flake.nix`:**
   - Update `username = "nikitalenyk";` to your username
   - Update `darwinConfigurations."MacBook-Pro-Nikita"` to your hostname

3. **Edit `home/home.nix`:**
   - Update `home.username = "nikitalenyk";`
   - Update `home.homeDirectory = "/Users/nikitalenyk";`
   - Update git `userName` and `userEmail`

4. **Apply the configuration:**

```bash
cd ~/nix-config
sudo darwin-rebuild switch --flake .
home-manager switch --flake .
```

## Package Distribution

### System Level (`darwin/configuration.nix`)

```bash
home-manager    # CLI tool for user config management
git            # Essential for nix operations
curl           # System networking tool
wget           # System networking tool
vim            # Fallback system editor
```

### User Level (`home/home.nix`)

```bash
wezterm        # Terminal emulator
zoxide         # Directory navigation
starship       # Shell prompt
bat            # Cat replacement with syntax highlighting
fd             # Find replacement
ripgrep        # Grep replacement
logisim-evolution  # Logic circuit simulator
```

## Usage

### System Configuration Changes

For changes to system-level settings, packages, or Darwin configuration:

```bash
sudo darwin-rebuild switch --flake .
```

### User Configuration Changes

For changes to user packages, dotfiles, or personal settings:

```bash
home-manager switch --flake .
```

### Available Home Manager Commands

```bash
home-manager news          # Read Home Manager updates
home-manager generations   # List configuration generations
home-manager rollback      # Roll back to previous generation
```

## Testing Your Setup

1. **Test System Configuration:**

   ```bash
   sudo darwin-rebuild switch --flake .
   ```

2. **Test Home Manager Configuration:**

   ```bash
   home-manager switch --flake .
   ```

3. **Verify Home Manager CLI:**

   ```bash
   which home-manager
   # Should return: /run/current-system/sw/bin/home-manager
   ```

## Shell Configuration

The setup includes:

- **Zsh** with completion, autosuggestion, and syntax highlighting
- **Zoxide** for smart directory navigation
- **Starship** for a modern shell prompt
- **Git** configuration with user details

## Directory Structure

```
nix-config/
├── flake.nix                 # Main flake with both configurations
├── flake.lock               # Lock file
├── darwin/
│   └── configuration.nix    # System-level configuration
├── home/
│   └── home.nix             # User-level configuration
├── dev-shells/              # Development environments
│   ├── cpp-cmake/
│   └── java-maven/
└── wezterm/                 # Terminal configuration files
```

### Wezterm Configuration Setup

The wezterm is installed via Home Manager and configured separately.

1. Create the wezterm config directory:

```bash
mkdir -p ~/.config/wezterm
```

2. Move the configuration files:

```bash
mv ~/nix-config/wezterm/* ~/.config/wezterm/
```

### Wezterm Shortcuts

- `Ctrl+A p` - Project selector
- `Ctrl+A f` - Workspace selector
- `Ctrl+A "` - Horizontal split
- `Ctrl+A %` - Vertical split
- `Ctrl+A h/j/k/l` - Navigate between splits
- `Ctrl+A r` - Resize mode

> [!IMPORTANT]
> Create `Projects` and `Workspaces` directories to use the selectors:
>
> ```bash
> mkdir -p ~/Projects ~/Workspaces
> ```

## Dev Shells

Development environments are available for different languages:

### Java Development Shell

```bash
nix develop ~/nix-config/dev-shells/java-maven
```

### C++ Development Shell

```bash
nix develop ~/nix-config/dev-shells/cpp-cmake
```

## Separated Setup Migration Instructions

1. The configuration now separates system and user packages
2. Use `home-manager switch --flake .` for user-level changes only
3. Use `sudo darwin-rebuild switch --flake .` for system-level changes only
