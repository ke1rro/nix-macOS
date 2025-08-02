# Nix packet manager configuration for macOS

## Utilities and Packages

```bash
    wezterm
    zoxide
    starship
    bat
    fd
    ripgrep
```

## Important Notes

> [!IMPORTANT]
> Make sure to use the latest version of Nix and Home Manager for compatibility. Also make sure to use the same nixpkgs version and darwin version as in this configuration.

> [!IMPORTANT]
> The reporitory maybe be updated with tons of utilities and packages, so make sure to check the `home.nix` if you need to add or remove something.

> [!IMPORTANT]
> Configuration is designed to work with zsh shell. If you are using a different shell, you may need to adjust the configuration accordingly.

> [!WARNING]
> The configuration is using the unstable version of Home Manager and Nixpkgs. It is recommended to use the stable version for production use.

## Includes

- Home Manager configuration for user-specific settings
- Flake configuration for system setup and package management
- Darwin configuration for macOS-specific settings

### Wezterm Configuration Setup

The wezterm installed via nix.

1. Make sure to create a directory `~/.config/wezterm` if it does not exist.

```bash
mkdir -p ~/.config/wezterm
```

2. Move the files from the `wezterm` directory to the `~/.config/wezterm` directory.

```bash
mv ~/nix-config/wezterm/* ~/.config/wezterm/
```

## Shortcuts

- `Ctrl+A p` - Project selector
- `Ctrl+A f` - Workspace selector
- `Ctrl+A "` - Horizontal split
- `Ctrl+A %` - Vertical split
- `Ctrl+A h/j/k/l` - Navigate between splits
- `Ctrl+A r` - Resize mode

> [!IMPORTANT]
> Create `Projects` and `Workspaces` directories in your home directory to use the project and workspace selectors.

```bash
mkdir -p ~/Projects
mkdir -p ~/Workspaces
```

## Nix Setup

1. Install Flake

```bash
mkdir -p ~/.config/nix
echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf
```

2. Install Darwin & home-manager

```bash
nix run nix-darwin --extra-experimental-features nix-command --extra-experimental-features flakes
```

3. Create directories for configuration and darwin and move the files there

```bash
mkdir -p ~/nix-config/{darwin,home}
mv ~/nix-config/darwin/* ~/nix-config/darwin/
mv ~/nix-config/home/* ~/nix-config/home/
```

4. Put flake.nix in the root of the `nix-config` directory

```bash
mv ~/nix-config/flake.nix ~/nix-config/
```

5. Change the username and home directory in the `flake.nix` file to your username and home directory

```bash
# to get your username
whoami
```
6. Change the darwinConfigurations.`hostname` in the `flake.nix` file to your hostname

```bash
# to get your hostname
hostname
```
7. Change the `home.username` and `home.homeDirectory` in the `home.nix` file to your username and home directory

```bash
# to get your username
whoami
# to get your home directory
echo $HOME
```
8. Change the userName and userEmail in the `home.nix` file to your full name and email to use with git

9. Run the darwin-rebuild command

```bash
cd ~/nix-config && sudo darwin-rebuild switch --flake .
```
