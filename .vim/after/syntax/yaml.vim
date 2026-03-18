
syn match mkiClusterClaim  /\v[a-z]{2,3}-[a-z]{3}[a-z0-9]{3,5}-[a-z0-9_-]{1,24}/ containedin=@yamlScalarWithSpecials contains=mkiClusterEnv

syn match mkiClusterEnv    /\v(qa|stg|prd)/ nextgroup=mkiClusterSep1 contained
syn match mkiClusterSep1   /-/ nextgroup=mkiClusterCSP contained
syn match mkiClusterCSP    /\v[a-z]{3}/ nextgroup=mkiClusterRegion contained
syn match mkiClusterRegion /\v[a-z0-9]{3,5}/ nextgroup=mkiClusterSep2 contained
syn match mkiClusterSep2   /-/ nextgroup=mkiClusterClaim contained
syn match mkiClusterClaim  /\v[a-z0-9-]{1,24}/ contained

hi def link mkiClusterClaim   Identifier
hi def link mkiClusterEnv     Constant
hi def link mkiClusterCSP     Type
hi def link mkiClusterRegion  Statement
