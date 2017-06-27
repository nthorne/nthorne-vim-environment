""" common.vim
"""   - contains commonly used functions
"""


" function common#OpenBuffer() {{{
"   helper function for opening a buffer named by function argument 
function! common#OpenBuffer(buffer_name)
  if !bufexists(a:buffer_name)
    " if the buffer does not exist, create
    execute "below 15split ".a:buffer_name
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
    setlocal nobuflisted
    setlocal nomodifiable
    setlocal nolist
    setlocal nowrap
    setlocal nospell
  else
    if -1 == bufwinnr(a:buffer_name)
      " if the buffer exists, but isn't visible, split it shown
      execute "below 15split ".a:buffer_name
    endif

    " switch to the buffer
    execute bufwinnr(a:buffer_name)."wincmd w"

    nnoremap <buffer> <silent> <F4> :close<CR>
    nnoremap <buffer> <silent> <F5> :close<CR>
  endif
endfunction
" }}}


" function common#IsWorkHost() {{{
"   returns true if the current host name matches that of a host
"   at work
function! common#IsWorkHost()
  return hostname() =~ 'gbguxs\d\+'
endfunction
" }}}

" function! common#IsWorkVM() {{{
"   returns true if the current host name matches that of my work VM
function! common#IsWorkVM()
  return hostname() =~ "mintvm" || hostname() =~ "nixos"
endfunction
" }}}

" function! common#CleanupCppBeforeWrite() {{{
"   perform pre-write cleanup of cpp files
function! common#CleanupCppBeforeWrite()
  " Store cursor position
  let l:line = line(".")
  let l:col = col(".")

  " Clean trailing whitespaces..
  exec ':silent! %s/\s\+$//'
  let @/=''
  "`z

  " Restore cursor position
  call cursor(l:line, l:col)
endfunction
" }}}
