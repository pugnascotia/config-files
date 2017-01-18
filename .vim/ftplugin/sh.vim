" Lint shell scripts
if executable('shellcheck') == 1
  autocmd! BufWritePost <buffer> :! shellcheck -x %
endif
