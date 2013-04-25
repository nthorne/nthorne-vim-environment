""" cpp.vim
"""   - provides cpp specific settings
"""


" Only load this ftplugin once per buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1


""" }}}
""" general settings {{{
"""

if common#IsWorkHost() || common#IsWorkVM()
  call work#ConstructPath()
else
 nnoremap <buffer> <silent> <localleader>ud :!ctags -R --exclude='.git' --c++-kinds=+p --fields=+iaS --extra=+q . <CR>
endif

setlocal foldmethod=syntax

" mark lines longer than 80 characters
match ErrorMsg '\%>80v.\+'

" OmniCppComplete settings
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD", "GPU3", "TCC"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

""" }}}
