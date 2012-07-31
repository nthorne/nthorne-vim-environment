" work.vim
"   contains work related vim functions
"


" function for linting a specific file
" NOTE: this one is not needed atm, but i'll keep it around if we switch
"   back to not using the lint host (i.e. use a proper lint tool)
"
"function! s:LintFile(file)
"  botright lwindow
"  let ignores = system('find . -type f -name "*.cpp" ! -name "*Test.cpp" ! -name '.escape(a:file,'%#'))
"  let files = substitute(ignores, "\./", "", "g")
"  let files = substitute(files, "\n", " ", "g")
"  cexpr system('gmake LINTIGNORE="'.escape(files,'%#').'" lint')
"  cope
"  1
"endfunction
"command! -complete=file -nargs=+ Lif call s:LintFile(<q-args>)


" determine if the current file is ready for checkin
function! work#CanCheckin()
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
function! work#TestUnit()
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
function! work#LintUnit()
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

