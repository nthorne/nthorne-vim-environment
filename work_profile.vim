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

" <F3> simply does a non-optimized recursive build
nnoremap <silent> <F3> :make NO_OPTIMIZATION=y<CR>
" <F4> runs the current unit test, or the unit test for the current unit
nnoremap <silent> <F4> :call TestUnit()<CR>
" <F5> runs QACPP on the lint host, for the current unit
nnoremap <silent> <F5> :call LintUnit()<CR>
" <C-C> does a sanity check of the unit, making sure it is ok for checking in
nnoremap <silent> <C-C> <ESC>:call CanCheckin()<CR>


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


"""
""" user defined functions
"""

" function for linting a specific file
function! s:LintFile(file)
  botright lwindow
  let ignores = system('find . -type f -name "*.cpp" ! -name "*Test.cpp" ! -name '.escape(a:file,'%#'))
  let files = substitute(ignores, "\./", "", "g")
  let files = substitute(files, "\n", " ", "g")
  cexpr system('gmake LINTIGNORE="'.escape(files,'%#').'" lint')
  cope
  1
endfunction
command! -complete=file -nargs=+ Lif call s:LintFile(<q-args>)

" determine if the current file is ready for checkin
function! CanCheckin()
  let remoteFullName = substitute(expand('%:p'), '/solhome', '', 'g')
  let remotePath = substitute(system('dirname '.remoteFullName), '\n', '', 'g')
  let filename = substitute(system('basename '.remoteFullName), '\n', '', 'g')
  let lintFile = '.lint/'.filename.'.err'

  let result=system('rsh gbguxs03 "source /etc/profile; cd '.remotePath.'; pwd; gmake -k '.lintFile.'"')

  let scratch = 'Debug logs: '.system('fgrep "\"666\"" '.expand('%:p').' | wc -l')
  let scratch = scratch.'TODO count: '.system('fgrep TODO '.expand('%:p').' | wc -l')."\n"
  let scratch = scratch."QACPP remarks:\n"
  let scratch = scratch.system('cat '.substitute(lintFile, '.err', '.log', '').'| sed "1d"')
  vimgrep '"666"' %
  vimgrep TODO %

  " put todo tag count in a new scratch buffer
  below 15new
  setlocal buftype=nofile bufhidden=hide noswapfile
  put = scratch
  1d
  resize 15
  wincmd j

endfunction

" run the unit test of the current unit, or the unit test if one is currently active
function! TestUnit()
  if !filereadable(@%)
    return
  endif

  let filename = @%

  if @% =~ 'Test\.[ch]pp$'
    let pathname = system('dirname '.filename)
    let testpath = substitute(pathname, '\n', '', 'g')
    let unitTestBaseName = substitute(substitute(system('basename '.filename), '\n', '', 'g'), '\.[ch]pp', '', 'g')
  else
    let pathname = system('dirname '.filename)
    let testpath = substitute(pathname, '\n', '', 'g').'/test'

    let unitTestBaseName = substitute(substitute(system('basename '.filename), '\n', '', 'g'), '\.[ch]pp', 'Test', 'g')
  endif

  let tbinpath = testpath.'/.out'
  let testBinary = tbinpath.'/'.unitTestBaseName

  " set up a new buffer (for debugging)
  below 15new
  setlocal buftype=nofile bufhidden=hide noswapfile

  if filereadable(testBinary)
    exe 'silent !rm '.testBinary
  endif

  exe 'make NO_OPTIMIZATION=y 'testBinary

  if filereadable(testBinary)
    let runString = 'LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/nthorne/TCC_SW/Distribution/SunOS_i86pc/lib:$XERCES_ROOT/lib '.testBinary
    put = system(runString)
  else
    close
    return
  endif

  " drop the empty newline at the top of the buffer
  1d

  " drop any pool constructor messages
  exec 'silent g/pool[\[0-9\]\+]/ d'

  " drop any pool destructor log statements
  exec 'silent g/\~pool/ d'

"  exec 'silent G'
endfunction

" lint the current unit
function! LintUnit()
  if !filereadable(@%)
    return
  endif

  let filename = substitute(@%, 'hpp', 'cpp', 'g')

  let fullpath = expand("%:p:h")

  let errFile = '.lint/'.filename.'.err'
  let logFile = '.lint/'.filename.'.log'

  " set up a new buffer (for debugging)
  below 15new
  setlocal buftype=nofile bufhidden=hide noswapfile

  if filereadable(errFile)
    exe 'silent !rm '.errFile
  endif

  let out = system('ssh linthost "source /etc/zprofile ; cd /host/'.fullpath.' ; make NO_OPTIMIZATION=y '.errFile.'"')
  put = errFile
  put = out

  put = logFile
  exec 'r '.logFile

  " drop the 'unknown error'
  exec 'silent g/Unknown error$/ d'

  " drop any complexity that is 'too low' to bother about
  exec 'silent g/STCYC = [1-5]/ d'

  " drop empty lines
  exec 'silent g/^[ \t]*$/ d'
endfunction

