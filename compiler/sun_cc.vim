" Vim compiler file
" Compiler:         Sun CC
" Maintainer:       Niklas Thorne 
" Latest Revision:  2010-06-28

if exists("current_compiler")
  finish
endif
let current_compiler = "sun_cc"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

CompilerSet errorformat+=%f(%l\\,%c):\ %m

CompilerSet makeprg=gmake

let &cpo = s:cpo_save
unlet s:cpo_save
