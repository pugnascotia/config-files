#!/bin/bash

set -ex

git clone https://github.com/Chiel92/vim-autoformat.git
git clone https://github.com/alunny/pegjs-vim.git
git clone https://github.com/chase/vim-ansible-yaml.git
git clone https://github.com/dagwieers/asciidoc-vim.git
git clone https://github.com/derekwyatt/vim-scala.git
git clone https://github.com/editorconfig/editorconfig-vim.git
git clone https://github.com/ekalinin/Dockerfile.vim.git
git clone https://github.com/fatih/vim-go.git
git clone https://github.com/hashivim/vim-terraform.git
git clone https://github.com/kchmck/vim-coffee-script.git
git clone https://github.com/mxw/vim-jsx.git
git clone https://github.com/pangloss/vim-javascript.git
git clone https://github.com/pearofducks/ansible-vim
git clone https://github.com/tpope/vim-fugitive.git
git clone https://github.com/reasonml-editor/vim-reason-plus
git clone https://github.com/w0rp/ale.git
git clone https://github.com/leafgarland/typescript-vim.git

curl -s -o nginx.tar.gz http://hg.nginx.org/nginx/archive/tip.tar.gz/contrib/vim/
mkdir nginx
tar xzf nginx.tar.gz -C nginx --strip-components=3
rm nginx.tar.gz

