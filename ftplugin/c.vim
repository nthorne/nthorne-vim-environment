""" c.vim
"""   - provides c specific settings
"""


" Only load this ftplugin once per buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1


""" }}}
""" general settings {{{
"""

if common#IsWorkHost()  || common#IsWorkVM()
  call work#ConstructPath()
else
  nnoremap <buffer> <silent> <localleader>ud :!ctags -R --exclude='.git' --exclude=".direnv" --c-kinds=+p --fields=+iaS --extra=+q . <CR>
endif

setlocal foldmethod=syntax

" mark lines longer than 80 characters
match ErrorMsg '\%>80v.\+'

""" }}}
