#!/bin/bash
# System-wide .profile for sh(1)

export BASH_SILENCE_DEPRECATION_WARNING=1

if [ -x /usr/libexec/path_helper ]; then
  eval $(/usr/libexec/path_helper -s)
fi

if [ "${BASH-no}" != "no" ]; then
	[ -r /etc/bashrc ] && . /etc/bashrc
fi

if [ -r "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
fi

eval $(/opt/homebrew/bin/brew shellenv)

if [[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]]; then
  . "$(brew --prefix)/etc/profile.d/bash_completion.sh"
fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# add Pulumi to the PATH
if [ -d "$HOME/.pulumi/bin" ]; then
  export PATH=$PATH:$HOME/.pulumi/bin
fi

if [[ -d "$HOME/.cargo/bin" ]]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

export PATH="/opt/homebrew/opt/node@16/bin:$PATH"

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/rory/opt/google-cloud-sdk/path.bash.inc' ]; then . '/Users/rory/opt/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/rory/opt/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/rory/opt/google-cloud-sdk/completion.bash.inc'; fi

if hash pyenv 2>/dev/null; then
  eval "$(pyenv init --path)"
fi
