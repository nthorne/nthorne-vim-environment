""" work_vm.vim
"""   - contains work related functions
"""


" function work_vm#CanCheckIn() {{{
"   determine if the current file is ready for checkin (i.e. grep the file for
"   debug log statements, todo statements and lint it)it).
function! work_vm#CanCheckin()
  if !filereadable(@%)
    return
  endif

  " store this one for later on
  let l:full_path=expand('%:p')

  " vimgrep for the debug logs and TODO:s so that we can navigate them via
  " the error list.
  vimgrep /"666"\|TODO/ %

  " run lint on the unit (this will setup the work_buffer buffer as well)
  call work_vm#LintUnit()

  let l:analysis = ''

  let l:analysis = l:analysis."---------------\n"
  let l:analysis = l:analysis.'Debug logs: '.system(
    \'ssh '.$REMOTE_HOST.' fgrep "\"666\"" '.l:full_path.' | wc -l')
  let l:analysis = l:analysis.'TODO count: '.system(
    \'ssh fgrep TODO '.l:full_path.' | wc -l')
  let l:analysis = l:analysis."---------------\n"
  let l:analysis = l:analysis."QACPP remarks:\n"

  " goto the first line, and put the analysis output there
  execute bufwinnr('work_buffer') . "wincmd w"
  1g
  put = l:analysis
  1d
endfunction
" }}}


" function work_vm#TestUnit() {{{
"   run the unit test of the current unit, or the currently open unit test
function! work_vm#TestUnit()
  if !filereadable(@%)
    return
  endif

  call work_vm#SyncWorkArea()

  let l:modulePath=expand("%:p:h")

  if @% =~ 'Test\.[ch]pp$'
    " if the current file is a unit test, grab names and paths
    let l:testpath = substitute(expand("%:h"), '\n', '', 'g')
    let l:fullpath = substitute(l:modulePath, '\n', '', 'g')
    let l:test_base_name = substitute(
      \substitute(expand("%:t"), '\n', '', 'g'), '\.[ch]pp', '', 'g')
    let l:modulePath = substitute(l:modulePath, '\/test$', '', 'g')
  else
    " else, if not a unit test, append /test to the unit path, and construct
    " a proper Makefile recipe target (i.e. <UnitName>Test)
    let l:testpath = substitute(expand("%:h"), '\n', '', 'g').'/test'
    let l:fullpath = substitute(l:modulePath, '\n', '', 'g').'/test'
    let l:test_base_name = substitute(
      \substitute(expand("%:t"), '\n', '', 'g'), '\.[ch]pp', 'Test', 'g')
  endif

  let l:translatedPath = work_vm#TranslateLocalPathToRemote(l:fullpath)

  " the test binaries are stored under test/.out
  let l:test_bin = './test/.out/'.l:test_base_name
  let l:remote_test_bin = l:translatedPath.'/.out/'.l:test_base_name

  " open a new work_buffer, and clear it
  call common#OpenBuffer('work_buffer')
  " clear the buffer
  setlocal modifiable
  exec 'silent u 1  | silent u'
  setlocal nomodifiable

  exe 'silent !ssh '.$REMOTE_HOST.' "rm '.l:remote_test_bin.' 2>/dev/null"'


  " TODO: This is a dirty, ugly hack. But it works.
  let &makeprg = "ssh ".$REMOTE_HOST." \"source /etc/profile; cd "
  let &makeprg = &makeprg.work_vm#TranslateLocalPathToRemote(l:modulePath)
  let &makeprg = &makeprg." ; gmake \""
  exe 'make NO_OPTIMIZATION=y '.l:test_bin

  " if the test did build..
  "let l:output=system('ssh '.$REMOTE_HOST.' test -f '.l:remote_test_bin)
  exe 'silent !ssh '.$REMOTE_HOST.' test -f '.l:remote_test_bin
  if 0 == v:shell_error
    " .. run it, with a sane LD_LIBRARY_PATH and XERCES path
    let l:run_string = 'ssh '.$REMOTE_HOST.' "cd '.l:translatedPath.'/.. ;'
    let l:run_string = l:run_string.'LD_LIBRARY_PATH=$LD_LIBRARY_PATH:'
    let l:run_string = l:run_string.'/opt/ACE-5.6.1/ACE_wrappers/lib:'
    let l:run_string = l:run_string.'/opt/xerces/lib test/.out/'.l:test_base_name
    let l:run_string = l:run_string.'"'
    setlocal modifiable
    0put = system(l:run_string)
    setlocal nomodifiable
  else
    " .. otherwise, close the work_buffer, and return
    close
    return
  endif

  setlocal modifiable
  " drop any pool constructor messages
  exec 'silent g/pool[\[0-9\]\+]/ d'

  " drop any pool destructor log statements
  exec 'silent g/\~pool/ d'
  setlocal nomodifiable
endfunction
" }}}


" function work_vm#LintUnit() {{{
"   lint the current unit
function! work_vm#LintUnit()
  if !filereadable(@%)
    return
  endif

  call work_vm#SyncWorkArea()

  " the cpp file is the target for the Makefile recipe, so we'll go ahead
  " and construct that name, if we're editing a header file
  let l:filename = substitute(expand("%:t"), 'hpp', 'cpp', 'g')
  if !filereadable(expand("%:h")."/".l:filename)
    return
  endif

  let l:full_path = expand("%:p:h")
  let l:translatedPath = work_vm#TranslateLocalPathToLint(l:full_path)

  let l:error_file = '.lint/'.l:filename.'.err'
  let l:remote_error_file = l:translatedPath.'/'.l:error_file
  echom l:remote_error_file
  let l:log_file = '.lint/'.l:filename.'.log'
  let l:remote_log_file = l:translatedPath.'/'.l:log_file

  call common#OpenBuffer('work_buffer')
  " clear the buffer
  setlocal modifiable
  exec 'silent u 1'
  exec 'silent u'
  setlocal nomodifiable

  "if filereadable(l:error_file)
    " if the error-file already existed, remove it to force lintage
    exe 'silent !ssh gbguxs10 "rm '.l:remote_error_file. ' 2>/dev/null"'
  "endif

  " open an ssh-session to the lint host, and Make the lint error-file
  let l:ssh_command = 'ssh linthost "source /etc/zprofile ; cd '
  let l:ssh_command = l:ssh_command.'/'.l:translatedPath
  let l:ssh_command = l:ssh_command.' ; make NO_OPTIMIZATION=y '.l:error_file.'"'
  let l:output = substitute(system(l:ssh_command), '', '', 'g')

  setlocal modifiable
  0put = l:error_file.':'
  put = l:output

  " read the log file input into the buffer
  put = l:log_file.':'
  let l:run_string='ssh linthost "source /etc/profile; cat '
  let l:run_string=l:run_string.l:remote_log_file
  let l:run_string=l:run_string.'"'
  put = system(l:run_string)
  "silent! exec 'r '.l:log_file

  " drop the 'unknown error'
  exec 'silent g/Unknown error$/ d'

  " drop any complexity that is 'too low' to bother about
  exec 'silent g/STCYC = [1-5]$/ d'

  " drop empty lines
  exec 'silent g/^[ \t]*$/ d'

  " modify the path to match local path
  exec 'silent %s/.*nthorne/\~/g'
  setlocal nomodifiable
endfunction
" }}}


" function! work_vm#ConstructPath() {{{
"   Construct the path variable based on configuration file detailing current
"   project
function! work_vm#ConstructPath()
  if exists("$CURRENT_WORK_PROJECT_PATH")
    if isdirectory($CURRENT_WORK_PROJECT_PATH)
      exec 'set path+='.$CURRENT_WORK_PROJECT_PATH.'/**/Distribution/include'
      exec 'set path+='.$CURRENT_WORK_PROJECT_PATH.'/**/Implementation/source'
    endif
  endif
endfunction
" }}}

" function! work_vm#SyncWorkArea() {{{
"   Sync the work are to the remote host
function! work_vm#SyncWorkArea()
  let l:full_path = expand("%:p:h")

  if (match(l:full_path, $CURRENT_WORK_PROJECT_PATH) != -1)
    exec 'silent !synctcc.sh'
  endif
endfunction
" }}}

" function! work_vm#BuildToQuickFix() {{{
"   Execute a custom build script and send its output to quickfix
function! work_vm#BuildToQuickFix()
  " The option to doing this dirty hack is
  "   cexpr system("buildtcc.sh")
  "   copen
  " the downside then is that we get a non-responsive, non-indicative
  " session until the command has terminated..

  let l:prev_make=&l:makeprg
  setlocal makeprg=buildtcc.sh

  if @% =~ '[Ss]tub\.cpp$'
    make stub_targets
  else
    make
  endif

  let &l:makeprg=l:prev_make
endfunction
" }}}

" function! work_vm#LocalBuildToQuickFix() {{{
"   Execute a custom build script and send its output to quickfix
function! work_vm#LocalBuildToQuickFix()
  let l:prev_make=&makeprg

  if @% =~ '[Ss]tub\.cpp$'
    setlocal makeprg=localbuildtcc.sh\ %:p:h:h
    make stub_targets
  else
    setlocal makeprg=localbuildtcc.sh\ %:p:h\ %:t
    make
  endif

  let &l:makeprg=l:prev_make
endfunction
" }}}

" function! work_vm#LocalMakeToQuickFix() {{{
"   Execute a custom build script and send its output to quickfix
function! work_vm#LocalMakeToQuickFix()
  let l:prev_make=&makeprg

  if @% =~ '[Ss]tub\.cpp$'
    setlocal makeprg=localmaketcc.sh\ %:p:h:h
    make stub_targets
  else
    setlocal makeprg=localmaketcc.sh\ %:p:h
    make
  endif

  let &l:makeprg=l:prev_make
endfunction
" }}}

" function! work_vm#LcdToProjectRoot() {{{
"   lcd to project root
function! work_vm#LcdToProjectRoot()
  exec ':lcd '.$CURRENT_WORK_PROJECT_PATH
endfunction
" }}}

" function! work_vm#OpenUnitTest() {{{
"   open the unit test of a cpp/hpp file
" arguments:
"  newtab - if non-zero, the test is opened in a new tab
function! work_vm#OpenUnitTest(newtab)
  if @% =~ 'Test\.[ch]pp$'
    " if the current file is a unit test, we're done
    return
  endif

  " else, if not a unit test, construct the full path to the ./test folder..
  let l:fullpath = substitute(expand("%:p:h"), '\n', '', 'g').'/test'
  " .. and add Test to the end of filename
  let l:test_base_name = substitute(
    \substitute(expand("%:t"), '\n', '', 'g'), '\(\.[ch]pp\)', 'Test\1', 'g')
  let l:test_name=l:fullpath.'/'.l:test_base_name


  if filereadable(l:test_name)
    let l:curdir=getcwd()

    if 0 == a:newtab
      exe 'edit '.l:test_name
    else
      exec 'tabedit '.l:test_name
    endif

    exe 'lcd '.l:curdir
  else
    echo ''.l:test_name.': no such file'
  endif
endfunction
" }}}

" function! work_vm#TranslateLocalPathToRemote() {{{
"   translate a local path to a remote one
"
" arguments:
"   localPath - the local path
" returns:
"   a path on the remote server
function! work_vm#TranslateLocalPathToRemote(localPath)
  return substitute(a:localPath, $CURRENT_WORK_PROJECT_PATH, $CURRENT_WORK_PROJECT_REMOTE_PATH, "")
endfunction
" }}}

" function! work_vm#TranslateLocalPathToLint() {{{
"   translate a local path to a lint path
"
" arguments:
"   localPath - the local path
" returns:
"   a path on the lint server
function! work_vm#TranslateLocalPathToLint(localPath)
  return substitute(a:localPath, $CURRENT_WORK_PROJECT_PATH, $CURRENT_WORK_PROJECT_LINT_PATH, "")
endfunction
" }}}

" function! work_vm#GetExtraIncluePaths() {{{
"   Build include paths to be sent to compilers and tidyers.
"
" returns:
"   A string containing the include paths to consider.
function! work_vm#GetExtraIncluePaths()
  let l:system_path=system("echo | clang -v -E -x c++ - 2>&1 | sed -e '1,/^#include <...> search starts here:$/d' | sed -e '/^End of search list.$/,$d' | awk '{print \"-I\"$1}'")
  if (!exists("$CURRENT_WORK_PROJECT_PATH"))
    let l:local_path=""
  else
    let l:local_path=system("find $CURRENT_WORK_PROJECT_PATH/ -type d -name include | awk '{print \"-I\"$0}'")
  endif

  return l:system_path." ".l:local_path
endfunction
" }}}
