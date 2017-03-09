#!/bin/bash

OS_TYPE=$(uname -s)

digoc() {
    # shellcheck disable=SC2029
    ssh -i ~/.ssh/digitalocean "root@$1"
}

if [ "$OS_TYPE" = Darwin ]; then
    find() {
        if [[ "$@" == "" ]]; then
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
