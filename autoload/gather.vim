""" gather.vim
"""   - defines the Gather function
"""


" function gather#Gather() {{{
"   search the current buffer for _patter_, and display the results in a new
"   buffer.
"
" arguments:
"   pattern - the pattern to search for
" returns:
"   -
function! gather#Gather(pattern)
  if !empty(a:pattern)
    " save the cursor position
    let save_cursor = getpos(".")
    " save the file type of the original file
    let orig_ft = &ft

    let results = []
    " append search hits to results list
    execute "g/" . a:pattern . "/call add(results, getline('.'))"

    " position the cursor att the stored position
    call setpos('.', save_cursor)

    if !empty(results)
      " if we had any results, put them in a new scratch buffer
      call common#OpenBuffer('gather_buffer')

      " clear the buffer
      %d

      " set the buffer filetype to match that of the original file
      execute "setlocal filetype=".orig_ft

      " append the results to the new buffer..
      call append(1, results)
      " .. and deelte the initial blank line
      1d 
    endif
  endif
endfunction
" }}}

