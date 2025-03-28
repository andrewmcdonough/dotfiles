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
export PATH=/opt/homebrew/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:$HOME/bin:$GOPATH/bin:/opt/homebrew/bin/:$HOME/.local/bin:$PATH
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

aws-profile () {
  if [ $# -eq 0 ]
  then
    echo "$AWS_PROFILE"
    return 0
  fi
  if [[ "$1" == "clear" ]]
  then
    unset AWS_PROFILE
  else
    export AWS_PROFILE="$1"
  fi
}

# Use startship prompt: https://starship.rs/
eval "$(starship init zsh)"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Activate asdf for version management
. $HOME/.asdf/asdf.sh

fpath=(${ASDF_DIR}/completions $fpath)
autoload -Uz compinit
compinit

eval 
TWILIO_AC_ZSH_SETUP_PATH=/Users/amcdonough/.twilio-cli/autocomplete/zsh_setup && test -f $TWILIO_AC_ZSH_SETUP_PATH && source $TWILIO_AC_ZSH_SETUP_PATH; # twilio autocomplete setup
if [ -f "/Users/amcdonough/.config/fabric/fabric-bootstrap.inc" ]; then . "/Users/amcdonough/.config/fabric/fabric-bootstrap.inc"; fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/amcdonough/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/amcdonough/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/amcdonough/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/amcdonough/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
