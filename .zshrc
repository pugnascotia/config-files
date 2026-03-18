#!/bin/zsh

OS_TYPE=$(uname -s)

export EDITOR=vim
export VISUAL=vim

if [ "$OS_TYPE" = Darwin ]; then
    export CLICOLOR=1
fi

set -o vi

# Use <Esc>-_ to fill the last argument in the previous command
bindkey -M viins '\e_' insert-last-word

# When editing commands, allow backspacing over existing characters
bindkey "^?" backward-delete-char

# Use Ctrl-R for searching even when in vi mode
bindkey '^R' history-incremental-search-backward

# Use <Esc>-v to edit current command in $EDITOR
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# append to the history file, don't overwrite it
setopt APPEND_HISTORY

# no duplicate in history
setopt HIST_IGNORE_DUPS

# don't put lines starting with space in the history.
setopt HIST_IGNORE_SPACE

# Ignore commands starting with #
setopt interactivecomments

# load zsh completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

# Don't put certain commands in the history. These must match the entire # command.
# zshaddhistory() {
#   case ${1%% *} in 
#     (fg|bg|vim|ls) return 1;;
#   esac
#   return 0;
# }

# Ignore some entries when tab completing
FIGNORE="$FIGNORE:.DS_Store"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
# shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
    screen) color_prompt=yes;;
esac

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
else
    color_prompt=
fi

my_hostname=$(hostname -s)

case "$my_hostname" in
  rory-laptop) my_hostname="laptop" ;;

  Lucys-MacBook-Pro.local) my_hostname="macbook-pro" ;;

  Rorys-MBP) my_hostname="elastic" ;;
  Rorys-MBP-2) my_hostname="elastic" ;;
  Rorys-MacBook-Pro) my_hostname="elastic" ;;
  MacBook-Pro) my_hostname="elastic" ;;
  RorysMacBookM1) my_hostname="elastic" ;;
esac

setopt prompt_subst
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git

precmd () {
    vcs_info
    jobscount=${(M)#${jobstates%%:*}:#suspended}
    if [[ $jobscount == 0 ]]; then jobscount=; else jobscount=" ${jobscount}"; fi
}

if [ "$color_prompt" = yes ]; then
    zstyle ':vcs_info:*' formats ' %F{yellow}(%b)%f' # e.g. (main)
    PS1=$'%F{cyan}%n%F{red}@%F{cyan}$my_hostname %F{yellow}%D{%K:%M}%F{red}${jobscount}%F{red}%F${vcs_info_msg_0_}%F{none} %~\n>> '
else
    PS1=$'%n@$my_hostname %D{%K:%M}${jobscount}%F${vcs_info_msg_0_} %~\n>> '
fi

if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

if [ -f ~/.zsh_functions ]; then
    . ~/.zsh_functions
fi


if [ "$OS_TYPE" = "Darwin" ]; then
    export JAVA_HOME=$(/usr/libexec/java_home)
    export RUNTIME_JAVA_HOME=$(/usr/libexec/java_home)
    export JAVA11_HOME=$(/usr/libexec/java_home -v 11)
fi

if [[ "$OS_TYPE" = "Darwin" && -d /usr/local/Cellar/node/ ]]; then
    export PATH="$PATH:/opt/homebrew/bin"
    for VERSION in /usr/local/Cellar/node/*; do
        if [[ -e "$VERSION/bin/node" ]]; then
            export PATH="$PATH:$VERSION/bin"
        fi
    done
fi

# export VAULT_ADDR=https://secrets.elastic.co:8200

export GOPATH=$HOME

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [ -f /usr/local/var/ecl.auto ]; then
  source /usr/local/var/ecl.auto
fi

if hash pyenv 2>/dev/null; then
  eval "$(pyenv init -)"
fi

# Completion for kubectl
source <(kubectl completion zsh)

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/rory/opt/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/rory/opt/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/rory/opt/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/rory/opt/google-cloud-sdk/completion.zsh.inc'; fi

# AWS Config Bootstrap - auto-clones repo and sources helpers
_aws_config_bootstrap() {
  local repo="${XDG_DATA_HOME:-$HOME/.local/share}/platform-cli-auth"
  if [[ ! -d "$repo" ]]; then
    echo "Setting up AWS config helpers..." >&2
    git clone --quiet git@github.com:elastic/platform-cli-auth.git "$repo" >&2 || return 1
    echo "Done! Run 'aws-config set <role>' to configure your AWS profiles." >&2
  fi
  source "$repo/aws-config/shell-helper.sh" 2>/dev/null
  source "$repo/aws-config/mfa" 2>/dev/null
}
_aws_config_bootstrap
unset -f _aws_config_bootstrap

# Allow `platform-devenv` tool to know who I am in telemetry
export DEVENV_TELEMETRY_ALLOW_USERNAME=true

export PATH="$HOME/bin:$PATH:$JAVA_HOME/bin:$HOME/.local/bin"
