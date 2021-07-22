" Include Java syntax
syn region  htmlString   contained start=+'+ end=+'+
syn region  htmlDoubleString   contained start=+"+ end=+"+

syn region jspComment start="/\*" end="\*/" contained

syn region jspScriptlet matchgroup=jspTag start=/<%/  keepend end=/%>/ contains=htmlString,jspComment,htmlDoubleString
syn region jspExpr	matchgroup=jspTag start=/<%=/ keepend end=/%>/ contains=htmlString,jspComment,htmlDoubleString

hi def link groovyExpr Expression
hi def link jspComment Comment
" hi def link jspTag		 Identifier
hi def link htmlString String

syn match groovyELExpr /\${.\{-}}/ 
syn match groovyELExpr /\$[a-zA-Z_][a-zA-Z0-9_.]*/ 
hi def link groovyELExpr Identifier
