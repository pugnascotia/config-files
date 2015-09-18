" rory.hunter@blackpepper.co.uk Tue Aug 26 09:33:46 BST 2014

syntax on
filetype plugin indent on

" Use Pathogen to manage plugins.
call pathogen#infect()
call pathogen#helptags()

" Respect modelines, please
set modeline

" Visually display searches
set hlsearch

" But make it easy to disable them
map <BS> :nohlsearch<CR>

" Search incrementally
set incsearch

" Shotcut for switching windows
map <Tab> <C-W><C-W>

" Display tabs as 4 spaces
set tabstop=4

" Shift indentation by four spaces
set shiftwidth=4

" And tab is four spaces
set softtabstop=4

" Don't expand tabs
set noexpandtab

" Always show the status line
set laststatus=2

" Default column width
set textwidth=75

" Break on words, not in the middle of them
set linebreak

" And color the active one yellow
highlight StatusLine ctermfg=yellow

" Add 'r' to insert the comment leader when hitting <Enter> in a comment, and
" 'l' to avoid breaking lines that were already longer than 'textwidth'.
set formatoptions=crql

" Allow '~' (flip character case) to be used with movement operators.
set tildeop

set suffixesadd=.java,.js

" Fix speling
cab W w
cab Set set

" Shortcut to insert a timestamp
iab dts rory.hunter@blackpepper.co.uk <Esc>:r!date<CR>kJA

" Highlight current line
set cursorline

"--------------------------------------------------------------------------

" Override annoying default mappings
map <S-Down> <Down>
map <S-Up> <Up>

"--------------------------------------------------------------------------

highlight CursorLine cterm=NONE ctermbg=DarkGrey

" I prefer green comments
highlight Comment ctermfg=darkgreen cterm=NONE

highlight DiffText ctermbg=yellow ctermfg=black cterm=NONE

highlight Folded ctermbg=red ctermfg=black cterm=NONE

autocmd BufNewFile,BufRead *Vagrantfile* set ft=ruby

autocmd BufNewFile,BufRead hosts.* set ft=ini

autocmd BufNewFile,BufRead *.gitignore set ft=config

autocmd BufNewFile,BufRead * if match(getline(1),"node") >= 0 | set filetype=javascript | endif
