#!/bin/bash

# Set defaults
defaults write com.apple.screencapture location "~/Screenshots"

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
