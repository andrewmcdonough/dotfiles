export GOPATH=$HOME/go
export NODE_PATH="/usr/local/lib/node"
export NODE_ENV=development
export PATH=/usr/bin:/usr/local/opt/python/libexec/bin:/usr/local/bin/:/opt/local/bin:/opt/local/sbin:/usr/local/sbin:/usr/local/share/npm/bin:/opt/android/platform-tools:/opt/android/tools:/usr/local/mysql/bin:/var/lib/gems/1.8/bin:~/bin:/usr/local/opt/icu4c/bin:$GOPATH/bin:$PATH

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

# Bash completion
# Prerequsites:  brew install bash-completion git-extras
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

# Prompt - hostname, git prompt
PS1='\[\033[01;33m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;31m\]$(__git_ps1)\[\033[01;35m\]$\[\033[00m\] '

# I prefer chruby and chgems to rvm or rbenv as they are less magic
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh

# Don't put secrets in the .bashrc
source ~/.secrets/environment

# OS Dependent
case `uname` in
'Darwin')
# Mac specific settings
  alias vi='/usr/local/bin/vim'
  alias ctags='/usr/local/bin/ctags'
# End Mac specific settings
;;
'Linux')
# Linux specific settings
  alias vi='/usr/bin/vi'
# End Linux specific settings
;;
esac
