#!/bin/bash

set -e

function clone () {
  repo="$1"

  dir="$(basename "$1")"

  if [[ -d "$dir" ]]; then
    (cd "$dir" && git pull "$repo")
  else
    git clone "$repo"
  fi
}

clone https://github.com/Chiel92/vim-autoformat
clone https://github.com/alunny/pegjs-vim
clone https://github.com/chase/vim-ansible-yaml
clone https://github.com/dagwieers/asciidoc-vim
clone https://github.com/derekwyatt/vim-scala
clone https://github.com/editorconfig/editorconfig-vim
clone https://github.com/ekalinin/Dockerfile.vim
clone https://github.com/fatih/vim-go
clone https://github.com/hashivim/vim-terraform
clone https://github.com/kchmck/vim-coffee-script
clone https://github.com/leafgarland/typescript-vim
clone https://github.com/mxw/vim-jsx
clone https://github.com/nelstrom/vim-subrip
clone https://github.com/pangloss/vim-javascript
clone https://github.com/pearofducks/ansible-vim
clone https://github.com/reasonml-editor/vim-reason-plus
clone https://github.com/tpope/vim-commentary
clone https://github.com/tpope/vim-fugitive
clone https://github.com/tpope/vim-repeat
clone https://github.com/tpope/vim-surround
clone https://github.com/udalov/kotlin-vim
clone https://github.com/vim-airline/vim-airline
clone https://github.com/w0rp/ale
