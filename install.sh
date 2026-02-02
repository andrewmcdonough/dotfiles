#!/bin/bash

# Install vimplug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install chezmoi

# Install config
chezmoi apply

# Run unshared config
. ~/Dropbox/config/install.sh

# Install chruby
#wget -O chruby-0.3.9.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz
#tar -xzvf chruby-0.3.9.tar.gz
#cd chruby-0.3.9/
#sudo make install

# Install asdf
#git clone https://github.com/asdf-vm/asdf.git ~/.asdf
