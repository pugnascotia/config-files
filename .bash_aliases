#!/bin/sh

# Alias definitions.

if [ "$OS_TYPE" = "Darwin" ]; then
  alias ls='ls -Gp'
  alias siri="open /Applications/Siri.app"
fi

alias sl=ls
alias llh="ls -lh"
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Fix speling

alias bim=vim
alias cim=vim

alias got=git
alias gut=git
alias fit=git
alias gti=git

# evim == easy vim. BURN IN HELL YOU MONSTER
alias evim=vim

# Make jjs actually usable
alias jjs='rlwrap jjs'

alias fig=docker-compose

if [ "$OS_TYPE" = "Linux" ]; then
  # enable color support of ls and also add handy aliases
  if [ -x /usr/bin/dircolors ]; then
    if test -r ~/.dircolors; then
      eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    fi
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
  fi

  # Add an "alert" alias for long running commands.  Use like so:
  #   sleep 10; alert
  alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
fi

alias yanr=yarn
alias yarm=yarn

# Time management
alias SLEEP="timew stop && timew week && pmset sleepnow"
alias CONTINUE="timew continue && timew week"
alias COn="timew continue && timew week"

# Rebuild JavaScript tags 
alias jtags="ctags -R public server flow-typed scripts webpack && sed -i '' -E '/^(if|switch|function|module\.exports|it|describe).+language:js$/d' tags"

alias t=timew
