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

    restart-dock() {
      PID=$(ps x | awk '/MacOS\/Dock$/ { print $1 }')
      if [[ -n "$PID" ]]; then
        kill $PID
      fi
    }
fi

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

if [ -x "$HOME/bin/git-wrapper" ]; then
  git() {
    git-wrapper "$@"
  }
fi

function docbldesx() {
  GIT_HOME="$PWD/.."

  $GIT_HOME/docs/build_docs --doc $PWD/docs/reference/index.asciidoc --resource=$PWD/x-pack/docs/ --chunk 1 && \
    find $PWD/html_docs -type f | xargs perl -p -i -e 's#((?:src|href)=")/#${1}https://www.elastic.co/#g'

  if [[ $? -eq 0 ]]; then
    osascript -e 'display notification "Success 🤩" with title "build_docs"'
  else
    osascript -e 'display notification "Failed 🤬" with title "build_docs"'
  fi
}

function runDockerTests() {
  ./gradlew :qa:os:destructiveDistroTest.default${1}-docker --tests org.elasticsearch.packaging.test.DockerTests
}
