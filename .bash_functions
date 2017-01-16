#!/bin/bash

OS_TYPE=`uname -s`

digoc() {
    ssh -i ~/.ssh/digitalocean root@$1
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
fi

lint() {
    if [ -e package.json ]; then
        npm run lint
    else
        lint
    fi
}
