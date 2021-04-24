# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/amcdonough/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="random"
# echo $RANDOM_THEME

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

# https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
plugins=(git fzf direnv)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export GOPATH=$HOME/go
export NODE_PATH="/usr/local/lib/node"
export NODE_ENV=development
# export PATH=/usr/local/opt/curl/bin:/usr/bin:/usr/local/opt/python/libexec/bin:/usr/local/bin/:/opt/local/bin:/opt/local/sbin:/usr/local/sbin:/usr/local/share/npm/bin:/opt/android/platform-tools:/opt/android/tools:/usr/local/mysql/bin:/var/lib/gems/1.8/bin:$HOME/bin:/usr/local/opt/icu4c/bin:$HOME/.fastlane/bin:$GOPATH/bin:$PATH
export PATH=/usr/local/bin:/usr/local/opt/curl/bin:/usr/bin:/usr/local/opt/python/libexec/bin:/usr/local/bin/:/opt/local/bin:/opt/local/sbin:/usr/local/sbin:/usr/local/share/npm/bin:/opt/android/platform-tools:/opt/android/tools:/usr/local/mysql/bin:/var/lib/gems/1.8/bin:$HOME/bin:/usr/local/opt/icu4c/bin:$HOME/.fastlane/bin:$GOPATH/bin:$PATH

export MANPATH=/usr/local/git/man:/opt/local/share/man:$MANPATH
export EDITOR=/usr/local/bin/vim
export BLOCKSIZE=M # so du shows megabytes
export DISABLE_SPRING=true # I don't like Spring
export AWS_DEFAULT_REGION=eu-west-1
export GREP_OPTIONS="--exclude-dir=var/cache"
export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH
export ANDROID_SDK="/opt/android"
export DOCKER_BUILDKIT=1

# Keep aliases in a separate file
[[ -s "$HOME/.shell_aliases" ]] && source "$HOME/.shell_aliases"

# I prefer chruby and chgems to rvm or rbenv as they are less magic
[[ -r /usr/local/opt/chruby/share/chruby/chruby.sh ]] && source "/usr/local/opt/chruby/share/chruby/chruby.sh"
[[ -r /usr/local/opt/chruby/share/chruby/auto.sh ]] && source "/usr/local/opt/chruby/share/chruby/auto.sh"

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -r "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"

# Don't put secrets in shared config
[[ -r "$HOME/.secrets/environment" ]] && source "$HOME/.secrets/environment"

# OS Dependent
case `uname` in
'Darwin')
# Mac specific settings
  export OPERATING_SYSTEM=osx
  export LC_ALL=en_GB.UTF-8
  alias vi='/usr/local/bin/nvim'
  alias ctags='/usr/local/bin/ctags'

# End Mac specific settings
;;
'Linux')
# Linux specific settings
  export OPERATING_SYSTEM=linux
  alias vi='/usr/bin/vi'
# keychain id_rsa
# . ~/.keychain/`uname -n`-sh
# End Linux specific settings
;;
esac

# This loads nvm bash_completion
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"

# Use startship prompt: https://starship.rs/
eval "$(starship init zsh)"

# Default Ruby
chruby 2.7.0
