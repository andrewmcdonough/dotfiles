export GOPATH=$HOME/go
export NODE_PATH="/usr/local/lib/node"
export NODE_ENV=development
export PATH=/usr/local/opt/curl/bin:/usr/bin:/usr/local/opt/python/libexec/bin:/usr/local/bin/:/opt/local/bin:/opt/local/sbin:/usr/local/sbin:/usr/local/share/npm/bin:/opt/android/platform-tools:/opt/android/tools:/usr/local/mysql/bin:/var/lib/gems/1.8/bin:$HOME/bin:/usr/local/opt/icu4c/bin:$HOME/.fastlane/bin:$GOPATH/bin:$PATH
export PATH=/usr/local/bin:/usr/local/opt/curl/bin:/usr/bin:/usr/local/opt/python/libexec/bin:/usr/local/bin/:/opt/local/bin:/opt/local/sbin:/usr/local/sbin:/usr/local/share/npm/bin:/opt/android/platform-tools:/opt/android/tools:/usr/local/mysql/bin:/var/lib/gems/1.8/bin:$HOME/bin:/usr/local/opt/icu4c/bin:$HOME/.fastlane/bin:$GOPATH/bin:$PATH

export MANPATH=/usr/local/git/man:/opt/local/share/man:$MANPATH
export EDITOR=/usr/local/bin/vim
export BLOCKSIZE=M # so du shows megabytes
export DISABLE_SPRING=true # I don't like Spring
export AWS_DEFAULT_REGION=eu-west-1
export GREP_OPTIONS="--exclude-dir=var/cache"
#export LANG=C
export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH
export ANDROID_SDK="/opt/android"

# Keep aliases in a separate file
[[ -s "$HOME/.shell_aliases" ]] && source "$HOME/.shell_aliases"

# Hack - to get bash completion working on old computer
#source $HOME/.git-prompt.sh
#source $HOME/.git-completion

# Bash completion
# Prerequsites:  brew install bash-completion git-extras
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && source "/usr/local/etc/profile.d/bash_completion.sh"

# Prompt - hostname, git prompt
PS1='\[\033[01;33m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;31m\]$(__git_ps1)\[\033[01;35m\]$\[\033[00m\] '

# I prefer chruby and chgems to rvm or rbenv as they are less magic
[[ -r /usr/local/opt/chruby/share/chruby/chruby.sh ]] && source "/usr/local/opt/chruby/share/chruby/chruby.sh"
[[ -r /usr/local/opt/chruby/share/chruby/auto.sh ]] && source "/usr/local/opt/chruby/share/chruby/auto.sh"

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -r "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"

# Don't put secrets in the .bashrc
[[ -r "$HOME/.secrets/environment" ]] && source "$HOME/.secrets/environment"

# OS Dependent
case `uname` in
'Darwin')
# Mac specific settings
  export OPERATING_SYSTEM=osx
  export LC_ALL=en_GB.UTF-8
  alias vi='/usr/local/bin/vim'
  #alias vi='/usr/bin/vim'
  alias ctags='/usr/local/bin/ctags'
# End Mac specific settings
;;
'Linux')
# Linux specific settings
  export OPERATING_SYSTEM=linux
  alias vi='/usr/bin/vi'
# End Linux specific settings
;;
esac

[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# direnv for project environment variables
# https://direnv.net/
[ -x "$(command -v direnv)" ] && eval "$(direnv hook bash)"

[ -f $HOME/.fzf.bash ] && source $HOME/.fzf.bash
