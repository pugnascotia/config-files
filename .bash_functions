#!/bin/bash

OS_TYPE=$(uname -s)

if [ "$OS_TYPE" = Darwin ]; then
    find() {
        if [[ "$*" == "" ]]; then
            /usr/bin/find .
        elif [[ "${1:0:1}" == "-" ]]; then
            /usr/bin/find . "$@"
        else
            /usr/bin/find "$@"
        fi
    }

    # Pruned ps
    pps() {
        # shellcheck disable=SC2009
        ps | grep -v iTerm | grep -v bash | cut -c-$COLUMNS
    }

    copy-pass() {
        grep PASS .env | cut -f2 -d= | pbcopy
    }
fi

lint() {
    if [ -e package.json ]; then
        npm run lint "$@"
    else
        lint "$@"
    fi
}

yarn-link() {
  local packages
  packages=$(jq -r '.dependencies | to_entries | .[] | select(.value | startswith("file:")) | .key' package.json)

  for pkg in $packages; do
    yarn link "$pkg"
  done
}

deugly() {
  prettier "$@" | vim -c "setf javascript" -
}

refresh-env() {
  aws-mfa

  if make update-environment; then
    make show-credentials
    local newPassword
    newPassword="$( make show-credentials | awk '/Root password/ { print $NF }' )"
    sed -i.bak -e "s/E2E_PASSWORD=.*/E2E_PASSWORD=${newPassword}/" ../../../cloud-ui/.env
    osascript -e 'display notification "update-environment finished" with title "make"'
  else
    osascript -e 'display notification "update-environment failed!" with title "make"'
  fi
}

tint() {
  yarn flow && yarn lint-eslint --fix && yarn test
}

if [ -x "$HOME/bin/git-wrapper" ]; then
  git() {
    git-wrapper "$@"
  }
fi
