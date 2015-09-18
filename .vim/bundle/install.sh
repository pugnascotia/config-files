#!/bin/bash

set -ex

git clone https://github.com/ekalinin/Dockerfile.vim.git
git clone https://github.com/editorconfig/editorconfig-vim.git
git clone https://github.com/nginx/nginx.git
git clone https://github.com/alunny/pegjs-vim.git
git clone https://github.com/chase/vim-ansible-yaml.git
git clone https://github.com/kchmck/vim-coffee-script.git
git clone https://github.com/tpope/vim-fugitive.git
git clone https://github.com/fatih/vim-go.git
git clone https://github.com/derekwyatt/vim-scala.git
git clone https://github.com/markcornick/vim-terraform.git


ln -s nginx/contrib/vim vim-nginx
