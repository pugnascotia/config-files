" Vim syntax file
" Language:	Vim 7.2 script
" Filenames:    *.ini, .hgrc, */.hg/hgrc
" Maintainer:	Peter Hosey
" Last Change:	Nov 11, 2008
" Version:	7.2-02

" Quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn match   iniSection skipwhite "^\[.\+\]$" contains=iniLabel 
syn match   iniLabel  ":[^]]\+" contained

syn match   iniRule  "\w\+[=:]"
syn match   iniRule  "\<\w\+\>" 

syn match   iniValue  /[:=][^ ]\+/hs=s+1

syn match   iniComment skipwhite "^[#;].*"

" Highlighting Settings
" ====================

hi def link iniSection Keyword
hi def link iniRule Identifier
hi def link iniComment Comment
hi def link iniLabel Constant
hi def link iniValue String

let b:current_syntax = "ini"
