# Dotfiles

Personal configuration files and system setup, managed with [chezmoi](https://www.chezmoi.io/).

## What's included

- Shell configuration (zsh + [oh-my-zsh](https://ohmyz.sh/))
- Neovim config
- tmux config
- Git config
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

## Backups

Restic backs up to Backblaze B2 with client-side encryption. Credentials are stored in 1Password and fetched at runtime — no secrets in this repo.

### Per-machine setup

1. Install restic (`brew install restic` on macOS, `apt install restic` on Linux)
2. Create `~/.config/restic/paths` with one directory per line:
   ```
   /Users/you/Documents
   /Users/you/Projects
   ```
3. On the **first machine only**, initialize the repo: `restic-backup init`
4. Run a backup: `restic-backup`

### Usage

| Command | Description |
|---|---|
| `restic-backup` | Run a backup (reads paths from `~/.config/restic/paths`) |
| `restic-backup init` | Initialize the B2 repo (first machine only) |
| `restic-backup snapshots` | Show snapshots for this host |
| `restic-backup forget --keep-daily 7` | Any restic subcommand (pass-through) |

Common excludes (caches, build artifacts, `.git`, etc.) are managed in `~/.config/restic/excludes` (deployed by chezmoi). Per-machine paths in `~/.config/restic/paths` are not tracked in this repo.
