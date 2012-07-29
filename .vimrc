"""
""" general setup
"""

" initialise pathogen
call pathogen#infect()

" turn on syntax highlighting (with a stylish color scheme)
syntax on
colorscheme nthorne


"""
""" keybindings
"""

" <F2> toggles taglist
nnoremap <silent> <F2> :TlistToggle<CR>
