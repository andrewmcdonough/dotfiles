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

# Install packages from Brewfile (macOS only)
if is_macos; then
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    brew bundle install --file="${SCRIPT_DIR}/Brewfile"

    defaults write com.apple.screencapture location "~/Screenshots"
fi

# Install and enable SSH (Linux only)
if is_linux; then
    if ! dpkg -s openssh-server &>/dev/null; then
        echo "Installing openssh-server..."
        sudo apt update
        sudo apt install -y openssh-server
    fi
    if ! systemctl is-enabled ssh &>/dev/null; then
        echo "Enabling SSH..."
        sudo systemctl enable ssh
    fi
    if ! systemctl is-active ssh &>/dev/null; then
        echo "Starting SSH..."
        sudo systemctl start ssh
    fi
fi

# Set up SSH authorized keys
if [[ ! -d "${HOME}/.ssh" ]]; then
    echo "Creating ~/.ssh directory..."
    mkdir -p "${HOME}/.ssh"
    chmod 700 "${HOME}/.ssh"
fi
if [[ ! -f "${HOME}/.ssh/authorized_keys" ]]; then
    echo "Installing authorized keys..."
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    cp "${SCRIPT_DIR}/authorized_keys" "${HOME}/.ssh/authorized_keys"
    chmod 600 "${HOME}/.ssh/authorized_keys"
fi

# Run unshared config
if [[ -f ~/Dropbox/config/install.sh ]]; then
    . ~/Dropbox/config/install.sh
fi

# Install Claude Code
if ! command -v claude &>/dev/null; then
    curl -fsSL https://claude.ai/install.sh | bash
fi
