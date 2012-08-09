" this file contains some work-specific settings

"""
""" general settings {{{
"""

" set gmake as our :make program
setlocal makeprg=gmake

" extend the path for file motions to be useful
setlocal path+=~/CBR3/Implementation/source,~/RBA_LKAB/Implementation/source
setlocal path+=~/CBR3/Import/include,~/RBA_LKAB/Import/include
setlocal path+=~/CBR3/Distribution/include,~/RBA_LKAB/Distribution/include

setlocal path+=~/CBI3/Implementation/source,~/ILA_LKAB/Implementation/source
setlocal path+=~/CBI3/Import/include,~/ILA_LKAB/Import/include
setlocal path+=~/CBI3/Distribution/include,~/ILA_LKAB/Import/include


"""
""" filetype settins
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
  augroup END
endif


""" }}}
""" keybindings {{{

if has('autocmd')
  augroup nthorne_work_augroup
    " <localleader><F3> simply does a non-optimized recursive build
    au FileType cpp nnoremap <buffer> <silent> <localleader><F3> :make NO_OPTIMIZATION=y<CR>
    " <localleader><F4> runs the current unit test, or the unit test for the current unit
    au FileType cpp nnoremap <buffer> <silent> <localleader><F4> :call work#TestUnit()<CR>
    " <localleader><F5> runs QACPP on the lint host, for the current unit
    au FileType cpp nnoremap <buffer> <silent> <localleader><F5> :call work#LintUnit()<CR>

    " <localleader>cci does a sanity check of the unit (todos, debug statements
    " and lint)
    au FileType cpp nnoremap <buffer> <silent> <localleader>cci <ESC>:call work#CanCheckin()<CR>
  augroup END
endif


""" }}}
""" abbreviations {{{
"""

" project path abbreviations
cabbrev <buffer> cbr ~/CBR3/Implementation/source
cabbrev <buffer> rba ~/RBA_LKAB/Implementation/source

" common code snippets
cabbrev <buffer> ucbr using CBR3::
iabbrev <buffer> cmDist getDistance(Distance::CENTIMETER)
iabbrev <buffer> dbglog GPU3_LOG("666", critical, 


""" }}}
