""" filetype.vim
"""   - defines new file types
"""     (structure copied from http://vim.wikia.com/wiki/Filetype.vim)


if exists("did_load_filetypes")
  finish
endif


""" }}}
""" autocommands {{{
"""

augroup filetypedetect
    " make vim recognise cpp file types, and set the appropriate folding method
  au BufRead,BufNewFile *.hpp setlocal filetype=cpp
  au BufRead,BufNewFile *.cc setlocal filetype=cpp

  " work specific file types
  if common#IsWorkHost() || common#IsWorkVM()
    " set the appropriate filetype for tcc log files
    au BufRead,BufNewFile *.[0-9]*.log setlocal filetype=tcclog

    " set the appropriate filetype for the QACPP log files
    au BufRead,BufNewFile *.cpp.log setlocal filetype=qacpplog
  endif
augroup END

""" }}}
