""" work.vim
"""   - contains work related functions
"""


" function work#CanCheckIn() {{{
"   determine if the current file is ready for checkin (i.e. grep the file for
"   debug log statements, todo statements and lint it)it).
function! work#CanCheckin()
  if !filereadable(@%)
    return
  endif

  " store this one for later on
  let l:full_path=expand('%:p')

  " vimgrep for the debug logs and TODO:s so that we can navigate them via
  " the error list.
  vimgrep /"666"\|TODO/ %

  " run lint on the unit (this will setup the work_buffer buffer as well)
  call work#LintUnit()

  let l:analysis = ''

  let l:analysis = l:analysis."---------------\n"
  let l:analysis = l:analysis.'Debug logs: '.system(
    \'fgrep "\"666\"" '.l:full_path.' | wc -l')
  let l:analysis = l:analysis.'TODO count: '.system(
    \'fgrep TODO '.l:full_path.' | wc -l')
  let l:analysis = l:analysis."---------------\n"
  let l:analysis = l:analysis."QACPP remarks:\n"

  " goto the first line, and put the analysis output there
  execute bufwinnr('work_buffer') . "wincmd w"
  1g
  put = l:analysis
  1d
endfunction
" }}}


" function work#TestUnit() {{{
"   run the unit test of the current unit, or the currently open unit test
" arguments:
"   mkprg - the program used to build the unit test (since setlocal makeprg in
"     work_profile.vim is not propagated to this autoloaded function for some
"     strange reason).
function! work#TestUnit(mkprg)
  if !filereadable(@%)
    return
  endif

  if @% =~ 'Test\.[ch]pp$'
    " if the current file is a unit test, grab names and paths
    let l:testpath = substitute(expand("%:h"), '\n', '', 'g')
    let l:test_base_name = substitute(
      \substitute(expand("%:t"), '\n', '', 'g'), '\.[ch]pp', '', 'g')
  else
    " else, if not a unit test, append /test to the unit path, and construct 
    " a proper Makefile recipe target (i.e. <UnitName>Test)
    let l:testpath = substitute(expand("%:h"), '\n', '', 'g').'/test'
    let l:test_base_name = substitute(
      \substitute(expand("%:t"), '\n', '', 'g'), '\.[ch]pp', 'Test', 'g')
  endif

  " the test binaries are stored under test/.out
  let l:test_bin = l:testpath.'/.out/'.l:test_base_name

  " open a new work_buffer, and clear it
  call common#OpenBuffer('work_buffer')
  %d

  " if the test binary exists..
  if filereadable(l:test_bin)
    " .. remove it to force a test rebuild
    exe 'silent !rm '.l:test_bin
  endif

  " TODO: This is a dirty, ugly hack. But it works.
  let &makeprg=a:mkprg
  exe 'make NO_OPTIMIZATION=y '.l:test_bin

  " if the test did build..
  if filereadable(l:test_bin)
    " .. run it, with a sane LD_LIBRARY_PATH and XERCES path
    let l:run_string = 'LD_LIBRARY_PATH=$LD_LIBRARY_PATH:'
    let l:run_string = l:run_string.'/home/nthorne/TCC_SW/Distribution/SunOS_i86pc/lib:'
    let l:run_string = l:run_string.'$XERCES_ROOT/lib '.l:test_bin
    put = system(l:run_string)
  else
    " .. otherwise, close the work_buffer, and return
    close
    return
  endif

  " drop the empty newline at the top of the buffer
  1d

  " drop any pool constructor messages
  exec 'silent g/pool[\[0-9\]\+]/ d'

  " drop any pool destructor log statements
  exec 'silent g/\~pool/ d'
endfunction
" }}}


" function work#LintUnit() {{{
"   lint the current unit
function! work#LintUnit()
  if !filereadable(@%)
    return
  endif

  " the cpp file is the target for the Makefile recipe, so we'll go ahead
  " and construct that name, if we're editing a header file
  let l:filename = substitute(expand("%:t"), 'hpp', 'cpp', 'g')
  if !filereadable(expand("%:h")."/".l:filename)
    return
  endif

  let l:full_path = expand("%:p:h")

  let l:error_file = '.lint/'.l:filename.'.err'
  let l:log_file = '.lint/'.l:filename.'.log'

  call common#OpenBuffer('work_buffer')
  " clear the buffere
  %d

  if filereadable(l:error_file)
    " if the error-file already existed, remove it to force lintage
    exe 'silent !rm '.l:error_file
  endif

  " open an ssh-session to the lint host, and Make the lint error-file
  let l:ssh_command ='ssh linthost "source /etc/zprofile ; cd /host/'
  let l:ssh_command = l:ssh_command.l:full_path 
  let l:ssh_command = l:ssh_command.' ;make NO_OPTIMIZATION=y '.l:error_file.'"'
  let l:output = substitute(system(l:ssh_command), '', '', 'g')

  put = l:error_file.':'
  put = l:output

  " read the log file input into the buffer
  put = l:log_file.':'
  silent! exec 'r '.l:log_file

  " drop the 'unknown error'
  exec 'silent g/Unknown error$/ d'

  " drop any complexity that is 'too low' to bother about
  exec 'silent g/STCYC = [1-5]$/ d'

  " drop empty lines
  exec 'silent g/^[ \t]*$/ d'
endfunction
" }}}


" function! work#ReadProjectVariables() {{{
"   Read the project definitions variables from the configuration file that
"   details the current project
function! work#ReadProjectVariables()
  let l:current_project_file=$HOME.'/current_project.vim'
  if filereadable(l:current_project_file)
    exec 'source '.l:current_project_file
  endif
endfunction
" }}}

" function! work#ConstructPath() {{{
"   Construct the path variable based on configuration file detailing current
"   project
function! work#ConstructPath()
  call work#ReadProjectVariables()

  if exists("g:current_work_project_path")
    if isdirectory(g:current_work_project_path)
      exec 'set path+='.g:current_work_project_path.'/**/Distribution/include'
      exec 'set path+='.g:current_work_project_path.'/**/Implementation/source'
    endif
  endif
endfunction
" }}}

" function! work#AddCppUnitTest() {{{
"   Add a test case declaration, an add that test case to the test suite.
function! work#AddCppUnitTest()
  "exec 'normal! o'
  let testcase = input('Enter test case name: ')
  let purpose = input('Enter test case purpose: ')
  put = ''
  put = '  /**'
  put = '   * '.purpose
  put = '   */'
  put = '  void '.testcase.'(void);'
  exec "normal! ?_TEST_SUITE_END?\rOCPPUNIT_TEST(".testcase.");"
endfunction
" }}}
