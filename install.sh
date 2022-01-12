#!/bin/bash


mkdir -p ~/.config
mkdir -p ~/.config/yamllint
mkdir -p ~/.config/nvim/
mkdir -p ~/tmp

ln -s -f ~/dotfiles/vimrc ~/.vimrc
ln -s -f ~/dotfiles/gitconfig ~/.gitconfig
ln -s -f ~/dotfiles/git-completion.bash ~/.git-completion
ln -s -f ~/dotfiles/bashrc ~/.bashrc
ln -s -f ~/dotfiles/zshrc ~/.zshrc
ln -s -f ~/dotfiles/ackrc ~/.ackrc
ln -s -f ~/dotfiles/pryrc ~/.pryrc
ln -s -f ~/dotfiles/gitignore_global ~/.gitignore_global
ln -s -f ~/dotfiles/lynxrc ~/.lynxrc
ln -s -f ~/dotfiles/irbrc ~/.irbrc
ln -s -f ~/dotfiles/rspec ~/.rspec
ln -s -f ~/dotfiles/rubocop.yml ~/.rubocop.yml
ln -s -f ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s -f ~/dotfiles/shell_aliases ~/.shell_aliases
ln -s -f ~/dotfiles/yamllint.yaml ~/.config/yamllint/config
ln -s -f ~/dotfiles/eslint.yaml ~/.eslint.yaml
ln -s -f ~/dotfiles/git-completion.bash ~/.git-completion.bash
ln -s -f ~/dotfiles/git-prompt.sh ~/.git-prompt.sh
ln -s -f ~/dotfiles/starship.toml ~/.config/starship.toml
ln -s -f ~/dotfiles/init.vim ~/.config/nvim/init.vim

# Install vimplug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Install chruby
wget -O chruby-0.3.9.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz
tar -xzvf chruby-0.3.9.tar.gz
cd chruby-0.3.9/
sudo make install

# Install asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf
