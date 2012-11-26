nthorne-vim-environment
=======================

nthorne's vim environment

usage
-----
    $ cd ~
    $ git clone --recursive git://github.com/nthorne/nthorne-vim-environment.git .vim
    $ ln -s .vim/.vimrc

configuration
-------------
Defining the variable **g:current_work_project_path** in
*$HOME/current_project.vim* causes the **path** variable, for cpp files, to
contain all *Distribution/include* and *Implementation/source* folders for
easy source file navigation. Also, tagsfiles will be placed in the folder
defined in the project path variable.
