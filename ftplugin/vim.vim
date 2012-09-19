""" vim.vim
"""   - provides vim filetype specific settings
"""


" Only load this ftplugin once per buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

""" }}}
""" general settings {{{
"""

" us the marker foldmethod for vimscript
setlocal foldmethod=marker

" open the help for the word under the cursor
nnoremap <leader>h :help <C-R><C-W><CR>
" grep the help documentation for the word under the cursor
nnoremap <leader>hg :helpgrep <C-R><C-W><CR>


""" }}}
