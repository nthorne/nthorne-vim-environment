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
Defining the environment variable **$CURRENT_WORK_PROJECT_PATH**
causes the **path** variable, for cpp files, to contain all
*Distribution/include* and *Implementation/source* folders for
easy source file navigation. Also, tagsfiles will be placed in the folder
defined in the project path variable.
