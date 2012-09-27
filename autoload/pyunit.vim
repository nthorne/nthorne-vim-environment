""" pyunit.vim
"""   - contains function for running python unit tests using makeprg
"""


" function! pyunit#RunPyUnittest() {{{
"   helper function for setting compiler, makeprg and running the unit test. if
"   the name of the unit does not match test_\w.py, an attempt is made to open
"   the unit's unit test (test/test_'%:t')
function! pyunit#RunPyUnittest()
  " store the current makeprg so that we can restore it later on
  let l:prev_makeprg=&makeprg

  " if the open buffer contains a unit test
  if expand('%:t') =~ 'test_\w\+.py'
    " lcd to the buffer folder (in order for import statements to work)
    let l:test_path=expand('%:h')
    exec 'lcd '.l:test_path

    " and set makeprg so that python exec's the unit test
    let l:test_name=expand('%:t')
  else
    " the name of the test is expected to be test_'%:t' ..
    let l:test_name='test_'.expand('%:t')

    " .. and it should reside in a test subfolder
    let l:unit_path=expand('%:h')
    let l:test_path=l:unit_path
    
    if l:unit_path !~ '/*test'
      let l:test_path=l:test_path.'/test'
    endif

    " lcd to the test subfolder ..
    exec 'lcd '.l:test_path
    " .. and open the unit test in a new (if needed) buffer
    call common#OpenBuffer(l:test_name)
  endif

  " we'll just use the python interpreter (which is expected to exist in the
  " path) to run our unit test
  let l:make_prog='python '.l:test_name

  " set compiler to pymox to get get a more appropriate errorformat
  compiler pymox
  exec 'setlocal makeprg='.join(split(l:make_prog), '\ ')

  make
  
  " restore the previous makeprg
  exec 'setlocal makeprg='.join(split(l:prev_makeprg), '\ ')
endfunction
" }}}
