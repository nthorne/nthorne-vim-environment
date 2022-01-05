""" vimes_profile.vim
"""   - contains settings for the vimes host
"""


""" }}}
""" general settings {{{
"""

let g:ctrlp_working_path_mode='rw'

""" }}}
""" autocommands {{{
"""

if has('autocmd')
  augroup nthorne_vimes_augroup
    au!

    au FileType cpp set sw=4
    au FileType cpp set sts=4

  augroup END
endif

""" }}}
