""" work_profile.vim
"""   - contains work-specific settings
"""


""" }}}
""" general settings {{{
"""

" Apparently, NERDTree does not render menu properly at work, so we'll go
"  old-style
let NERDTreeDirArrows=0

" set gmake as our :make program
setlocal makeprg=gmake


""" }}}
""" autocommands {{{
"""

if has('autocmd')
  augroup nthorne_work_augroup
    au!

    " use the como compiler plugin where appropriate,
    " otherwise sun_cc
    if hostname() == "gbguxs04"
      au FileType cpp compiler como
    else
      au FileType cpp compiler sun_cc
    endif

    " <localleader><F3> simply does a non-optimized recursive build
    au FileType cpp nnoremap <buffer> <silent> <localleader><F3> :make NO_OPTIMIZATION=y<CR>
    " <localleader><F4> runs the current unit test, or the unit test for the current unit
    au FileType cpp nnoremap <buffer> <silent> <localleader><F4> :call work#TestUnit()<CR>
    " <localleader><F5> runs QACPP on the lint host, for the current unit
    au FileType cpp nnoremap <buffer> <silent> <localleader><F5> :call work#LintUnit()<CR>

    " <localleader>cci does a sanity check of the unit (todos, debug statements
    " and lint)
    au FileType cpp nnoremap <buffer> <silent> <localleader>cci <ESC>:call work#CanCheckin()<CR>

    " abbreviations for common code snippets
    au FileType cpp iabbrev <buffer> cmDist getDistance(Distance::CENTIMETER)
    au FileType cpp iabbrev <buffer> dbglog GPU3_LOG("666", critical, 
  augroup END
endif

""" }}}
""" keybindings {{{
"""

" Navigate the help with the ä key, rather than the slightly awkward default
nnoremap ä <C-]>


""" }}}
