""" cpp.vim
"""   - provides cpp specific settings
"""


" Only load this ftplugin once per buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1


""" }}}
""" general settings {{{
"""

if common#IsWorkHost() || common#IsWorkVM()
  call work#ConstructPath()
else
 nnoremap <buffer> <silent> <localleader>ud :!ctags -R --exclude='build' --exclude='CMakeFiles' --exclude='.git' --exclude=".direnv" --c++-kinds=+p --fields=+iaS --extra=+q . <CR>
endif

setlocal foldmethod=syntax

" mark lines longer than 110 characters
match ErrorMsg '\%>110v.\+'

" OmniCppComplete settings
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 0 " autocomplete after .
let OmniCpp_MayCompleteArrow = 0 " autocomplete after ->
let OmniCpp_MayCompleteScope = 0 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

" Neomake checkers
let g:neomake_cpp_cppclean_maker = {
      \ 'exe': 'cppclean',
      \ 'errorformat': '%f:%l: %m',
      \ 'cwd': '%:p:h'
      \}

if common#IsWorkVM()
  let g:neomake_cpp_enabled_makers = ['cppclean', 'clangtidy', 'clang', 'cppcheck']
  let g:neomake_cpp_cppclean_args = split(work_vm#GetExtraIncluePaths())
  let g:neomake_cpp_clangtidy_args = split(work_vm#GetExtraIncluePaths())
  let g:neomake_cpp_clang_args = split(work_vm#GetExtraIncluePaths())
  let g:neomake_cpp_clangcheck_args = split(work_vm#GetExtraIncluePaths())
  let g:neomake_cpp_cppcheck_args = split(work_vm#GetExtraIncluePaths())
  call add(g:neomake_cpp_cppcheck_args, "--enable=all")
  call add(g:neomake_cpp_cppcheck_args, "--std=c++14")
endif

""" }}}

""" }}}
""" autocommands {{{
"""
if has('autocmd')
  augroup nthorne_ftplugin_cpp_augroup
    au!
    au FileType cpp
      \ au BufWritePre <buffer> call common#CleanupCppBeforeWrite()
  augroup END
endif

""" }}}


