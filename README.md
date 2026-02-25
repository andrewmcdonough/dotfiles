# Dotfiles

Personal configuration files and system setup, managed with [chezmoi](https://www.chezmoi.io/).

## What's included

- Shell configuration (zsh + [oh-my-zsh](https://ohmyz.sh/))
- Neovim config
- tmux config
- Git config
- Karabiner key mappings (macOS)
- Homebrew packages (via Brewfile)

## How it works

[Chezmoi](https://www.chezmoi.io/) manages dotfiles by keeping a source directory (this repo) and applying it to your home directory. Files prefixed with `dot_` are placed as dotfiles in `~`. Run `chezmoi apply` to sync changes.

## Installation

Clone the repo, then run the install script:

```bash
bash install.sh
```

The script handles platform differences automatically:

- **macOS**: Installs Homebrew (if needed), installs chezmoi via Homebrew, and sets macOS defaults
- **Linux**: Installs chezmoi via its install script
- **Both**: Applies chezmoi config and installs oh-my-zsh (if not already present)
