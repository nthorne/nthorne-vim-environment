""" c.vim
"""   - provides c specific settings
"""


" Only load this ftplugin once per buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1


""" }}}
""" general settings {{{
"""

if common#IsWorkHost()  || common#IsWorkVM()
  call work#ConstructPath()
endif

nnoremap <buffer> <silent> <localleader>ud :!ctags -R --exclude='build' --exclude='CMakeFiles' --exclude='.git' --exclude=".direnv" --c-kinds=+p --fields=+iaS --extra=+q . <CR>
setlocal foldmethod=syntax

" mark lines longer than 80 characters
match ErrorMsg '\%>80v.\+'

if common#IsWorkVM()
  let g:neomake_c_enabled_makers = ['clangtidy', 'clang', 'clangcheck']
  let g:neomake_c_clangtidy_args = split(work_vm#GetExtraIncluePaths())
  let g:neomake_c_clang_args = split(work_vm#GetExtraIncluePaths())
  let g:neomake_c_clangcheck_args = split(work_vm#GetExtraIncluePaths())
endif
""" }}}

if has('autocmd')
  augroup nthorne_ftplugin_c_augroup
    au!
    au BufWritePre <buffer> call common#CleanupCppBeforeWrite()
  augroup END
endif


""" }}}
""" utility functions {{{
"""

" function! SilenceUnusedArgs() {{{
"   If executed when cursor is within parens, the entire parameter list will
"   be yanked, pasted two lines below, and all parameters will be prepended
"   with (void).
function! SilenceUnusedArgs()
  normal yi)
  normal jo  p
  s/[ ,] [^ ]\+/(void)/g
  s/) /)/g
  s/\(\w\)(/\1;(/g
  normal A;
endfunction
nnoremap <buffer> <silent> <localleader>sua :call SilenceUnusedArgs()<CR>
""" }}}

