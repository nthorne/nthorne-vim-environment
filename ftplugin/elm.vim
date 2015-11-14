""" elm.vim
"""   - provides elm specific settings
"""


" Only load this ftplugin once per buffer
if exists("b:did_own_ftplugin")
  finish
endif
let b:did_own_ftplugin = 1

""" }}}
""" keybindings {{{
"""
" <localleader><F1> executes elm make, with HTML output for the current file.
nnoremap <buffer> <silent> <localleader><F1> :!elm make % --output %:r.html<CR>
nnoremap <buffer> <silent> <localleader><F7> :!xdg-open %:r.html<CR>

""" }}}
