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


neovim configuration
--------------------
In order to use this configuration in neovim, create the file `$HOME/.config/nvim/init.vim`,
with the following contents:

    set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath = &runtimepath
    source ~/.vimrc

    luafile $HOME/.config/nvim/plugins.lua

Also symlink `plugins.lua` into that folder.
