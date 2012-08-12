""" sun_cc.vim
"""   - provides settings for the Sun CC compiler
"""


" allow overruling or adding to this file
if exists("current_compiler")
  finish
endif
let current_compiler = "sun_cc"

" if CompilerSet does not exist, define it as :setlocal
if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo   " store cpoptions
set cpo-=C              " allow line continuation

" define the 'errorformat' for the Sun CC compiler, so that we get error
" messages in the quick fix window
CompilerSet errorformat+=%f(%l\\,%c):\ %m

" we use gmake as our make program
CompilerSet makeprg=gmake

let &cpo = s:cpo_save   " restore cpoptions
unlet s:cpo_save
