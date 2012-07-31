" this file contains some work-specific settings

"""
""" general settings
"""

" set gmake as our :make program
set makeprg=gmake

" extend the path for file motions to be useful
set path+=~/CBR3/Implementation/source,~/RBA_LKAB/Implementation/source
set path+=~/CBR3/Import/include,~/RBA_LKAB/Import/include
set path+=~/CBR3/Distribution/include,~/RBA_LKAB/Distribution/include

set path+=~/CBI3/Implementation/source,~/ILA_LKAB/Implementation/source
set path+=~/CBI3/Import/include,~/ILA_LKAB/Import/include
set path+=~/CBI3/Distribution/include,~/ILA_LKAB/Import/include


"""
""" filetype settins
"""

" set the appropriate filetype for tcc log files
au BufRead,BufNewFile *.[0-9]*.log set filetype=tcclog

" use the como compiler plugin where appropriate,
" otherwise sun_cc
if hostname() == "gbguxs04"
	au BufRead,BufNewFile *.?pp compiler como
else
	au BufRead,BufNewFile *.?pp compiler sun_cc
endif

" set the appropriate filetype for the QACPP log files
au BufRead,BufNewFile *.cpp.log set filetype=qacpplog


"""
""" keybindings
"""

" contains the functions called by the keybindings defined below
runtime functions/work.vim

" <F3> simply does a non-optimized recursive build
nnoremap <silent> <F3> :make NO_OPTIMIZATION=y<CR>
" <F4> runs the current unit test, or the unit test for the current unit
nnoremap <silent> <F4> :call work#TestUnit()<CR>
" <F5> runs QACPP on the lint host, for the current unit
nnoremap <silent> <F5> :call work#LintUnit()<CR>
" <C-C> does a sanity check of the unit, making sure it is ok for checking in
nnoremap <silent> <C-C> <ESC>:call work#CanCheckin()<CR>


"""
""" abbreviations
"""

" project path abbreviations
cabbrev cbr ~/CBR3/Implementation/source
cabbrev rba ~/RBA_LKAB/Implementation/source

" common code snippets
cabbrev ucbr using CBR3::
iabbrev cmDist getDistance(Distance::CENTIMETER)
iabbrev dbglog GPU3_LOG("666", critical, 

