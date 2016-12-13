# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

OS_TYPE=`uname -s`

export EDITOR=vim
export VISUAL=vim

if [ "$OS_TYPE" = Darwin ]; then
    if [ -r /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-prompt.sh ]; then
        . /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-prompt.sh
    fi

    # Colourful "ls" please
    export CLICOLOR=1
fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# Don't put certain commands in the history. These must match the entire
# command.
HISTIGNORE=fg:bg:vim:ls

# Ignore some entries when tab completing
FIGNORE="$FIGNORE:DS_Store"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

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

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt

# RAH: gnome-terminal reports itself as "xterm"
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# https://wiki.archlinux.org/index.php/Color_Bash_Prompt
# Reset
color_reset='\e[0m'       # Text Reset

# Regular Colors
color_black='\e[0;30m'        # Black
color_red='\e[0;31m'          # Red
color_green='\e[0;32m'        # Green
color_yellow='\e[0;33m'       # Yellow
color_blue='\e[0;34m'         # Blue
color_purple='\e[0;35m'       # Purple
color_cyan='\e[0;36m'         # Cyan
color_white='\e[0;37m'        # White


my_hostname=$(hostname -s)

if [[ "$my_hostname" == "rory-laptop" ]]; then
    my_hostname="laptop"
fi

my_jobs() {
  count=$(echo $(jobs | wc -l))
    count=$(jobs | wc -l)
    str=" $count"
    if [[ $count -eq 0 ]]; then
        str=""
    fi
    echo "$str"
}

__docker_ps1() {
    if [[ "$DOCKER_HOST" != "" ]]; then
        if [[ "$(which lolcat)" == "" ]]; then
            color_red='\e[0;31m'
            echo -e " ${color_red}⚡" | lolcat
        else
            echo " ⚡" | lolcat -f
        fi
    fi
}

if [ "$color_prompt" = yes ]; then
    PS1="\${debian_chroot:+(\$debian_chroot)}${color_cyan}\u${color_red}@${color_cyan}${my_hostname} ${color_yellow}\\D{%H:%M}${color_red}\$(my_jobs)${color_yellow}\$(__docker_ps1)\$(__git_ps1) ${color_reset}\w\n>> "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h \\D{%H:%M}\$(my_jobs)\$(__git_ps1) \w\n>> '
fi

unset color_prompt force_color_prompt my_hostname

# If this is an xterm set the title to user@host dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h\$(__git_ps1) \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

if [ `uname -s` = Darwin ]; then
    alias ls='ls -Gp'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# vi mode: I like pain
set -o vi


# Less Colors for Man Pages
# http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline


if [ "$OS_TYPE" = Darwin ]; then
    export JAVA_HOME=`/usr/libexec/java_home`
else 
    export JAVA_HOME=/usr/lib/jvm/java-8-oracle/
fi

export IDEA_JDK=$JAVA_HOME

export PATH="$HOME/bin:$HOME/npm/bin:$JAVA_HOME/bin:/opt/node/bin:$PATH"

unset color_reset color_black color_red color_green color_yellow
unset color_blue color_purple color_cyan color_white

export GOPATH=$HOME
