# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Znap
## Download Znap, if it's not there yet.
[[ -f ~/Git/zsh-snap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/Git/zsh-snap

source ~/Git/zsh-snap/znap.zsh  # Start Znap

# `znap source` automatically downloads and starts your plugins.
znap source marlonrichert/zsh-autocomplete
# znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="random"
# echo $RANDOM_THEME

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

# https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
plugins=(git fzf direnv aws asdf)

source $ZSH/oh-my-zsh.sh

# User configuration

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
#
export GOPATH=$HOME/go
#export NODE_PATH="/usr/local/lib/node"
export NODE_ENV=development
# export PATH=/usr/local/opt/curl/bin:/usr/bin:/usr/local/opt/python/libexec/bin:/usr/local/bin/:/opt/local/bin:/opt/local/sbin:/usr/local/sbin:/usr/local/share/npm/bin:/opt/android/platform-tools:/opt/android/tools:/usr/local/mysql/bin:/var/lib/gems/1.8/bin:$HOME/bin:/usr/local/opt/icu4c/bin:$HOME/.fastlane/bin:$GOPATH/bin:$PATH
#export PATH=/usr/local/bin:/usr/local/opt/curl/bin:/usr/bin:/usr/local/opt/python/libexec/bin:/usr/local/bin/:/opt/local/bin:/opt/local/sbin:/usr/local/sbin:/usr/local/share/npm/bin:/opt/android/platform-tools:/opt/android/tools:/usr/local/mysql/bin:/var/lib/gems/1.8/bin:$HOME/bin:/usr/local/opt/icu4c/bin:$HOME/.fastlane/bin:$GOPATH/bin:/usr/local/anaconda3/bin:$PATH
export PATH=/usr/local/bin:/usr/local/opt/curl/bin:/usr/bin:/usr/local/opt/python/libexec/bin:/usr/local/bin/:/opt/local/bin:/opt/local/sbin:/usr/local/sbin:/opt/android/platform-tools:/opt/android/tools:/usr/local/mysql/bin:/var/lib/gems/1.8/bin:$HOME/bin:/usr/local/opt/icu4c/bin:$HOME/.fastlane/bin:$GOPATH/bin:/usr/local/anaconda3/bin:$PATH


export MANPATH=/usr/local/git/man:/opt/local/share/man:/usr/local/man$MANPATH
export BLOCKSIZE=M # so du shows megabytes
export DISABLE_SPRING=true # I don't like Spring
export AWS_DEFAULT_REGION=eu-west-1
export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH
export ANDROID_SDK="/opt/android"
export DOCKER_BUILDKIT=1

unsetopt hist_verify # Run !! immediately

# Keep aliases in a separate file
[[ -s "$HOME/.shell_aliases" ]] && source "$HOME/.shell_aliases"

# I prefer chruby and chgems to rvm or rbenv as they are less magic
[[ -r /usr/local/opt/chruby/share/chruby/chruby.sh ]] && source "/usr/local/opt/chruby/share/chruby/chruby.sh"
[[ -r /usr/local/opt/chruby/share/chruby/auto.sh ]] && source "/usr/local/opt/chruby/share/chruby/auto.sh"

# Node Version Manager
# TODO: Work out how to make this faster - disabling for noe
# export NVM_DIR="$HOME/.nvm"
# [ -r "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"

# Don't put secrets in shared config
[[ -r "$HOME/.secrets/environment" ]] && source "$HOME/.secrets/environment"

# OS Dependent
case `uname` in
'Darwin')
# Mac specific settings
  export OPERATING_SYSTEM=osx
  export EDITOR=/usr/local/bin/vim
  export LC_ALL=en_GB.UTF-8
  alias vi='/usr/local/bin/nvim'
  alias ctags='/usr/local/bin/ctags'

# End Mac specific settings
;;
'Linux')
# Linux specific settings
  export OPERATING_SYSTEM=linux
  export EDITOR=/usr/bin/vi
  alias vi='/usr/bin/vi'
# keychain id_rsa
# . ~/.keychain/`uname -n`-sh
# End Linux specific settings
;;
esac

# Make the history behave like bash
bindkey "$terminfo[kcuu1]" up-history
bindkey "$terminfo[kcud1]" down-history

# This loads nvm bash_completion
#[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"

# Use startship prompt: https://starship.rs/
eval "$(starship init zsh)"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# NVM - probably remove for asdf
#export NVM_DIR="$HOME/.config/nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Activate asdf
. $HOME/.asdf/asdf.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
