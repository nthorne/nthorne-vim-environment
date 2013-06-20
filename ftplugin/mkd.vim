""" mkd.vim
"""   - provides settings specific markdown files
"""


" Only load this ftplugin once per buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1


""" }}}
""" general settings {{{
"""

" turn on spell checking for markdown
setlocal spell

""" }}}

""" }}}
""" keybindings {{{
"""

" Increase heading level on row
nnoremap <localleader>hi mzV:s/\(#*\)[ ]\?/\1# \2/<CR>`z:let @/=''<CR>

" Decrease heading level on row
nnoremap <localleader>hd mzV:s/^#[ ]\?//<CR>`z:let @/=''<CR>

""" }}}
