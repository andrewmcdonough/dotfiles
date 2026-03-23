#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMBINED="${SCRIPT_DIR}/Brewfile.combined"

# Combine Brewfiles
cat "${SCRIPT_DIR}/Brewfile" > "${COMBINED}"
if [[ -f "${SCRIPT_DIR}/Brewfile.work" ]]; then
    cat "${SCRIPT_DIR}/Brewfile.work" >> "${COMBINED}"
fi

trap 'rm -f "${COMBINED}"' EXIT

# Show what would be installed
echo "=== Packages to install ==="
brew bundle check --file="${COMBINED}" 2>&1 || true
echo ""

# Show what would be removed
echo "=== Packages to remove ==="
brew bundle cleanup --file="${COMBINED}" 2>&1 || true
echo ""

read -rp "Apply these changes? [y/N] " answer
case "${answer}" in
    [yY]|[yY][eE][sS])
        echo "Installing packages..."
        brew bundle install --file="${COMBINED}"
        echo ""
        echo "Removing unlisted packages..."
        brew bundle cleanup --force --file="${COMBINED}"
        echo ""
        echo "Done."
        ;;
    *)
        echo "Aborted."
        ;;
esac
