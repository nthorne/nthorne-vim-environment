""" python.vim
"""   - provides python specific settings
"""


" Only load this ftplugin once per buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1


""" }}}
""" general settings {{{
"""

" override the 'default' setting with 2 spaces here, for PEP-8 compliance
setlocal tabstop=4        " use four spaces for each <Tab> in the file
setlocal shiftwidth=4     " use four spaces for each step of autoindent
setlocal softtabstop=4    " use four spaces for a <Tab>
setlocal expandtab        " use spaces rather than tabs
setlocal smarttab
setlocal backspace=2      " allow <BS> over autoindent, line breaks and insert start

setlocal textwidth=80

setlocal nosmartindent    " turn off this one to get python indentation running

" turn on python omnicompletion, which is super-useful, since it even displays
" the pydoc for the completed item!
setlocal omnifunc=pythoncomplete#Complete

" for python files, set the makeprg to pylint, so that we can utilize
" a compiler plugin with an errorformat
setlocal makeprg=pylint\ --reports=n\ --output-format=parseable\ %:p

" mark lines longer than 80 characters
match ErrorMsg '\%>80v.\+'

" jedi-vim settings
let g:jedi#goto_command = "<localleader>g"
let g:jedi#get_definition_command = "<localleader>d"
let g:jedi#rename_command = "<localleader>r"
let g:jedi#related_names_command = "<localleader>o"

" python-mode settings
let g:pymode_run = 0


""" }}}
""" keybindings {{{
"""

" for python, map the usual compile/lint/whatnot function keys for a
" coherent workflow
nnoremap <buffer> <silent> <localleader><F3> :!/usr/bin/env python %<CR>
nnoremap <buffer> <silent> <localleader><F4> :call pyunit#RunPyUnittest()<CR>
nnoremap <buffer> <silent> <localleader><F5> :make<CR>
nnoremap <buffer> <silent> <localleader><F6> :silent !coverage run %<CR>:!coverage report -m<CR>


""" }}}
