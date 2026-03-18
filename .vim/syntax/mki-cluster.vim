" Vim syntax file
" Language: MKI Cluster Names
" Maintainer: Auto-generated
" Latest Revision: 2026-01-26
"
" MKI cluster name pattern: ${short-env}-${short-csp}${short-region}-${claimName}
" - short-env: 3 characters (qa, dev, stg, prd, etc.)
" - short-csp: 3 characters (aws, azu, gcp, etc.)
" - short-region: 5 characters (use1, usc1, eau2, etc.)
" - claimName: up to 16 characters

" if exists("b:current_syntax")
"   finish
" endif

" Match the complete MKI cluster name pattern
" Pattern: ${short-env}-${short-csp}${short-region}-${claimName}
" Example: qa-azueau2-mki-unified-mgmt
syntax match mkiClusterName /\v[a-z]{2,3}-[a-z]{3}[a-z0-9]{3,5}-[a-z0-9-]{1,16}/
      " \ contains=mkiEnv,mkiSep1,mkiCsp,mkiRegion,mkiSep2,mkiClaimName

" " Individual components - order matters for proper matching
" syntax match mkiEnv /\v[a-z]{2,3}/ contained nextgroup=mkiSep1
" syntax match mkiSep1 /-/ contained nextgroup=mkiCsp
" syntax match mkiCsp /\v[a-z]{3}/ contained nextgroup=mkiRegion
" syntax match mkiRegion /\v[a-z0-9]{3,5}/ contained nextgroup=mkiSep2
" syntax match mkiSep2 /-/ contained nextgroup=mkiClaimName
" syntax match mkiClaimName /\v[a-z0-9\-]{1,16}\>/ contained

" " Define highlighting colors
" highlight default mkiEnv ctermfg=Green guifg=#50fa7b
" highlight default mkiSep1 ctermfg=DarkGray guifg=#6272a4
" highlight default mkiCsp ctermfg=Cyan guifg=#8be9fd
" highlight default mkiRegion ctermfg=Yellow guifg=#f1fa8c
" highlight default mkiSep2 ctermfg=DarkGray guifg=#6272a4
" highlight default mkiClaimName ctermfg=Magenta guifg=#ff79c6
"
highlight default mkiClaimName ctermfg=Magenta guifg=#ff79c6

" let b:current_syntax = "mki-cluster"
