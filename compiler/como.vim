""" como.vim
"""   - provides settings for the como compiler
"""


" allow overruling or adding to this file
if exists("current_compiler")
  finish
endif
let current_compiler = "como"

" if CompilerSet does not exist, define it as :setlocal
if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif


let s:cpo_save = &cpo   " store cpoptions
set cpo-=C              " allow line continuation

" define the 'errorformat' for the como compiler, so that we get error
" messages in the quick fix window
CompilerSet errorformat=\
            \%-W\"/opt/%f\"\\,\ line\ %l:\ %tarning:\ %m,%Z%m,\
            \%E\"%f\"\\,\ line\ %l:\ catastrophic\ %trror:\ %m,%Z%m,\
            \%E\"%f\"\\,\ line\ %l:\ %trror:\ %m,%Z%m,\
            \%W\"%f\"\\,\ line\ %l:\ %tarning:\ %m,%Z%m\

" CompilerSet makeprg=como\ %

let &cpo = s:cpo_save   " restore cpoptions
unlet s:cpo_save
