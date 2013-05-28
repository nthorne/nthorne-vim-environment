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
    au FileType cpp nnoremap <buffer> <silent> <localleader><F4> :call work#TestUnit(&makeprg)<CR>
    " <localleader><F5> runs QACPP on the lint host, for the current unit
    au FileType cpp nnoremap <buffer> <silent> <localleader><F5> :call work#LintUnit()<CR>

    " <localleader>cci does a sanity check of the unit (todos, debug statements
    " and lint)
    au FileType cpp nnoremap <buffer> <silent> <localleader>cci <ESC>:call work#CanCheckin()<CR>

    " abbreviations for common code snippets
    au FileType cpp iabbrev <buffer> cmDist getDistance(Distance::CENTIMETER)
    au FileType cpp iabbrev <buffer> dbglog GPU3_LOG("666", critical, 

    " keybindings and settings for working with ctags:
    "  If the g:current_work_project_path variable can be read from the
    "  configuration file that details the current project, then that directory
    "  will be used to store the tagsfile in.
    "
    " <localleader>ud updates the tagsfile
    call work#ReadProjectVariables()
    if exists("g:current_work_project_path")
      exec 'au FileType cpp nnoremap <buffer> <silent> <localleader>ud :!ctags -R --exclude="*.sql" --exclude=".git" --c++-kinds=+p --fields=+iaS --extra=+q -f '.g:current_work_project_path.'/.tags '.g:current_work_project_path.'<CR>'
      exec 'set tags+='.g:current_work_project_path.'/.tags'
    else
      au FileType cpp nnoremap <buffer> <silent> <localleader>ud :!ctags -R --exclude='*.sql' --exclude='.git' --c++-kinds=+p --fields=+iaS --extra=+q . <CR>
    endif

  augroup END
endif

""" }}}
""" keybindings {{{
"""

" Navigate the help with the ä key, rather than the slightly awkward default
nnoremap ä <C-]>

" Allow for a more american-esque colon
nnoremap ö :


""" }}}
