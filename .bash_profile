#!/bin/bash
# System-wide .profile for sh(1)

if [ -x /usr/libexec/path_helper ]; then
  eval $(/usr/libexec/path_helper -s)
fi

if [ "${BASH-no}" != "no" ]; then
	[ -r /etc/bashrc ] && . /etc/bashrc
fi

if [ -r "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
fi

if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
    . "$(brew --prefix)/etc/bash_completion"
fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# add Pulumi to the PATH
if [ -d "$HOME/.pulumi/bin" ]; then
  export PATH=$PATH:$HOME/.pulumi/bin
fi
