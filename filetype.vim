""" filetype.vim
"""   - defines new file types
"""     (structure copied from http://vim.wikia.com/wiki/Filetype.vim)


if exists("did_load_filetypes")
  finish
endif
" let did_load_filetypes = 1


""" }}}
""" autocommands {{{
"""

augroup filetypedetect
  " make vim recognise cpp file types, and set the appropriate folding method
  au BufRead,BufNewFile *.hpp setlocal filetype=cpp
  au BufRead,BufNewFile *.cc setlocal filetype=cpp
  au BufRead,BufNewFile *.h setlocal filetype=c

  " work specific file types
  if common#IsWorkHost() || common#IsWorkVM()
    au! BufRead,BufNewFile *.hal setfiletype hal
    au! BufRead,BufNewFile *.hal set syntax=java
  endif
augroup END

""" }}}
