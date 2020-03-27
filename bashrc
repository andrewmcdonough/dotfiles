export GOPATH=$HOME/go
export NODE_PATH="/usr/local/lib/node"
export NODE_ENV=development
export PATH=/usr/local/opt/curl/bin:/usr/bin:/usr/local/opt/python/libexec/bin:/usr/local/bin/:/opt/local/bin:/opt/local/sbin:/usr/local/sbin:/usr/local/share/npm/bin:/opt/android/platform-tools:/opt/android/tools:/usr/local/mysql/bin:/var/lib/gems/1.8/bin:~/bin:/usr/local/opt/icu4c/bin:~/.fastlane/bin:$GOPATH/bin:$PATH
export PATH=/usr/local/bin:/usr/local/opt/curl/bin:/usr/bin:/usr/local/opt/python/libexec/bin:/usr/local/bin/:/opt/local/bin:/opt/local/sbin:/usr/local/sbin:/usr/local/share/npm/bin:/opt/android/platform-tools:/opt/android/tools:/usr/local/mysql/bin:/var/lib/gems/1.8/bin:~/bin:/usr/local/opt/icu4c/bin:~/.fastlane/bin:$GOPATH/bin:$PATH

export MANPATH=/usr/local/git/man:/opt/local/share/man:$MANPATH
export EDITOR=/usr/local/bin/vim
export BLOCKSIZE=M # so du shows megabytes
export DISABLE_SPRING=true # I don't like Spring
export LC_ALL=en_GB.UTF-8
export AWS_DEFAULT_REGION=eu-west-1
export GREP_OPTIONS="--exclude-dir=var/cache"
#export LANG=C
export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH
export ANDROID_SDK="/opt/android"

if [ $TERM == "screen-256color" ] || [ $TERM == "xterm-256color" ]; then
  PS1='\[\033[01;33m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;31m\]$(__git_ps1)\[\033[01;35m\]$\[\033[00m\] '
else
  PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[00;36m\]\w\[\033[00m\]\$ '
fi

# Keep aliases in a separate file
if [ -f ~/.shell_aliases ]; then
    . ~/.shell_aliases
fi

# Hack - to get bash completion working on old computer
#source ~/.git-prompt.sh
#source ~/.git-completion

# Bash completion
# Prerequsites:  brew install bash-completion git-extras
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

# Prompt - hostname, git prompt
PS1='\[\033[01;33m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;31m\]$(__git_ps1)\[\033[01;35m\]$\[\033[00m\] '

# I prefer chruby and chgems to rvm or rbenv as they are less magic
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh

# Node Version Manager
 export NVM_DIR="$HOME/.nvm"
 [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"

# Don't put secrets in the .bashrc
source ~/.secrets/environment

# OS Dependent
case `uname` in
'Darwin')
# Mac specific settings
  alias vi='/usr/local/bin/vim'
  #alias vi='/usr/bin/vim'
  alias ctags='/usr/local/bin/ctags'
# End Mac specific settings
;;
'Linux')
# Linux specific settings
  alias vi='/usr/bin/vi'
# End Linux specific settings
;;
esac

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/amcdonough/Downloads/google-cloud-sdk/path.bash.inc' ]; then . '/Users/amcdonough/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/amcdonough/Downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/amcdonough/Downloads/google-cloud-sdk/completion.bash.inc'; fi

 [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

 # direnv for project environment variables
 # https://direnv.net/
 eval "$(direnv hook bash)"
