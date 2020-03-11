""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CSCOPE settings for vim           
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" This file contains some boilerplate settings for vim's cscope interface,
" plus some keyboard mappings that I've found useful.
"
" USAGE: 
" -- vim 6:     Stick this file in your ~/.vim/plugin directory (or in a
"               'plugin' directory in some other directory that is in your
"               'runtimepath'.
"
" -- vim 5:     Stick this file somewhere and 'source cscope.vim' it from
"               your ~/.vimrc file (or cut and paste it into your .vimrc).
"
" NOTE: 
" These key maps use multiple keystrokes (2 or 3 keys).  If you find that vim
" keeps timing you out before you can complete them, try changing your timeout
" settings, as explained below.
"
" Happy cscoping,
"
" Jason Duell       jduell@alumni.princeton.edu     2002/3/7
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" This tests to see if vim was configured with the '--enable-cscope' option
" when it was compiled.  If it wasn't, time to recompile vim... 
if has("cscope")

    """"""""""""" Standard cscope/vim boilerplate

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0

    " add any cscope database in current directory
    if filereadable("cscope.out")
        cs add cscope.out  
    " else add the database pointed to by environment variable 
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif

    " show msg when any other cscope db added
    set cscopeverbose  


    " The following maps all invoke one of the following cscope search types:
    "
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
    "

    nmap <localleader>cs :cs find s <C-R>=expand("<cword>")<CR><CR>	
    nmap <localleader>cg :cs find g <C-R>=expand("<cword>")<CR><CR>	
    nmap <localleader>cc :cs find c <C-R>=expand("<cword>")<CR><CR>	
    nmap <localleader>ct :cs find t <C-R>=expand("<cword>")<CR><CR>	
    nmap <localleader>ce :cs find e <C-R>=expand("<cword>")<CR><CR>	
    nmap <localleader>cf :cs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <localleader>ci :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <localleader>cd :cs find d <C-R>=expand("<cword>")<CR><CR>	


    " Same as above, but show result in vertical split.

    nmap <localleader>wcs :scs find s <C-R>=expand("<cword>")<CR><CR>	
    nmap <localleader>wcg :scs find g <C-R>=expand("<cword>")<CR><CR>	
    nmap <localleader>wcc :scs find c <C-R>=expand("<cword>")<CR><CR>	
    nmap <localleader>wct :scs find t <C-R>=expand("<cword>")<CR><CR>	
    nmap <localleader>wce :scs find e <C-R>=expand("<cword>")<CR><CR>	
    nmap <localleader>wcf :scs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <localleader>wci :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
    nmap <localleader>wcd :scs find d <C-R>=expand("<cword>")<CR><CR>	


    """"""""""""" key map timeouts
    "
    " By default Vim will only wait 1 second for each keystroke in a mapping.
    " You may find that too short with the above typemaps.  If so, you should
    " either turn off mapping timeouts via 'notimeout'.
    "
    "set notimeout 
    "
    " Or, you can keep timeouts, by uncommenting the timeoutlen line below,
    " with your own personal favorite value (in milliseconds):
    "
    "set timeoutlen=4000
    "
    " Either way, since mapping timeout settings by default also set the
    " timeouts for multicharacter 'keys codes' (like <F1>), you should also
    " set ttimeout and ttimeoutlen: otherwise, you will experience strange
    " delays as vim waits for a keystroke after you hit ESC (it will be
    " waiting to see if the ESC is actually part of a key code like <F1>).
    "
    "set ttimeout 
    "
    " personally, I find a tenth of a second to work well for key code
    " timeouts. If you experience problems and have a slow terminal or network
    " connection, set it higher.  If you don't set ttimeoutlen, the value for
    " timeoutlent (default: 1000 = 1 second, which is sluggish) is used.
    "
    "set ttimeoutlen=100

endif


