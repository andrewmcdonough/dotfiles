# Znap
## Download Znap, if it's not there yet.
[[ -f ~/Git/zsh-snap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/Git/zsh-snap

source ~/Git/zsh-snap/znap.zsh  # Start Znap

# `znap source` automatically downloads and starts your plugins.
# znap source marlonrichert/zsh-autocomplete
# znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
plugins=(git fzf direnv aws asdf)

source $ZSH/oh-my-zsh.sh

# Set language environment
export LANG=en_GB.UTF-8

export GOPATH=$HOME/go
export NODE_ENV=development
#export PATH=/usr/local/bin:/usr/local/opt/curl/bin:/usr/bin:/usr/local/opt/python/libexec/bin:/usr/local/bin/:/opt/local/bin:/opt/local/sbin:/usr/local/sbin:/opt/android/platform-tools:/opt/android/tools:/usr/local/mysql/bin:/var/lib/gems/1.8/bin:$HOME/bin:/usr/local/opt/icu4c/bin:$HOME/.fastlane/bin:$GOPATH/bin:/usr/local/anaconda3/bin:$PATH
export PATH=/usr/local/bin:/usr/bin:/usr/local/sbin:$HOME/bin:$GOPATH/bin:/opt/homebrew/bin/:$PATH

#export MANPATH=/usr/local/git/man:/opt/local/share/man:/usr/local/man$MANPATH
export BLOCKSIZE=M # so du shows megabytes
export AWS_DEFAULT_REGION=eu-west-1
export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH
export DOCKER_BUILDKIT=1

unsetopt hist_verify # Run !! immediately

# Keep aliases in a separate file
[[ -s "$HOME/.shell_aliases" ]] && source "$HOME/.shell_aliases"

# OS Dependent
case `uname` in
'Darwin')
# Mac specific settings
  export OPERATING_SYSTEM=osx
  export EDITOR=/opt/homebrew/bin/nvim
  export LC_ALL=en_GB.UTF-8
  alias vi=nvim
# End Mac specific settings
;;
'Linux')
# Linux specific settings
  export OPERATING_SYSTEM=linux
  export EDITOR=/usr/bin/vi
  alias vi='/usr/bin/vi'
# End Linux specific settings
;;
esac

# Make the history behave like bash
bindkey "$terminfo[kcuu1]" up-history
bindkey "$terminfo[kcud1]" down-history

# Use startship prompt: https://starship.rs/
eval "$(starship init zsh)"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Activate asdf for version management
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
eval 
TWILIO_AC_ZSH_SETUP_PATH=/Users/amcdonough/.twilio-cli/autocomplete/zsh_setup && test -f $TWILIO_AC_ZSH_SETUP_PATH && source $TWILIO_AC_ZSH_SETUP_PATH; # twilio autocomplete setup
