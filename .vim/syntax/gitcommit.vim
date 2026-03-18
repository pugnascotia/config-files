syn match GitIssueNumber /#[0-9]\+/
syn match GitJiraNumber /[A-Z]\{2,\}-[0-9]\+/

hi GitIssueNumber ctermfg=red cterm=bold
hi GitJiraNumber ctermfg=red cterm=bold
