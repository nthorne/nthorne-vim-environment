#!/usr/bin/env bash

# vim: filetype=sh

# Set IFS explicitly to space-tab-newline to avoid tampering
IFS=' 	
'


NAME=
# Make sure that we're not on NixOS; if so, avoid tampering with PATH
if [[ -f /etc/os-release ]]
then
  . /etc/os-release
fi

if [[ "NixOS" != "$NAME" ]]
then
  # If found, use getconf to constructing a reasonable PATH, otherwise
  # we set it manually.
  if [[ -x /usr/bin/getconf ]]
  then
    PATH=$(/usr/bin/getconf PATH)
  else
    PATH=/bin:/usr/bin:/usr/local/bin
  fi
fi

function error()
{
  echo "Error: $@" >&2
  exit 1
}


test -d ${HOME}/.vim || ln -s ${PWD} ${HOME}/.vim
pushd ${HOME}

ln -s .vim/.vimrc
mkdir -p ${HOME}/.config/nvim/init.vim

cat > ${HOME}/.config/nvim/init.vim <<Neovim_Heredoc
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
luafile $HOME/.config/nvim/plugins.lua
Neovim_Heredoc

cp .vim/plugins.lua .config/nvim/

popd
