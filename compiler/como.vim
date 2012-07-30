" Vim compiler file
" Compiler:         como compiler
" Maintainer:       Niklas Thorne 
" Latest Revision:  2010-06-28

if exists("current_compiler")
  finish
endif
let current_compiler = "como"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

CompilerSet errorformat=\
            \%-W\"/opt/%f\"\\,\ line\ %l:\ %tarning:\ %m,%Z%m,\
            \%E\"%f\"\\,\ line\ %l:\ catastrophic\ %trror:\ %m,%Z%m,\
            \%E\"%f\"\\,\ line\ %l:\ %trror:\ %m,%Z%m,\
            \%W\"%f\"\\,\ line\ %l:\ %tarning:\ %m,%Z%m\

" CompilerSet makeprg=como\ %

let &cpo = s:cpo_save
unlet s:cpo_save
