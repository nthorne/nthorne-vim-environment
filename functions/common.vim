" common.vim
"   contains common functions


" function common#OpenBuffer() {{{
"   helper function for opening a buffer named by function argument 
function! common#OpenBuffer(buffer_name)
  if !bufexists(a:buffer_name)
    " if the buffer does not exist, create
    execute "below 15split ".a:buffer_name
    setlocal buftype=nofile bufhidden=hide noswapfile
  else
    if -1 == bufwinnr(a:buffer_name)
      " if the buffer exists, but isn't visible, split it shown
      execute "below 15split ".a:buffer_name
    endif

    " switch to the buffer
    execute bufwinnr(a:buffer_name)."wincmd w"
  endif
endfunction
" }}}
