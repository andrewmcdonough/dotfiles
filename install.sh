#!/bin/bash
set -euo pipefail

is_macos() {
    [[ "$(uname -s)" == "Darwin" ]]
}

is_linux() {
    [[ "$(uname -s)" == "Linux" ]]
}

# Install homebrew (macOS only)
if is_macos && ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install chezmoi
if ! command -v chezmoi &>/dev/null; then
    if is_macos; then
        brew install chezmoi
    elif is_linux; then
        sh -c "$(curl -fsLS get.chezmoi.io)"
    fi
fi

# Apply config
chezmoi apply

# macOS-specific setup
if is_macos; then
    defaults write com.apple.screencapture location "~/Screenshots"
fi

# Install oh-my-zsh
if [[ ! -d "${HOME}/.oh-my-zsh" ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Run unshared config
. ~/Dropbox/config/install.sh
