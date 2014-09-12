#!/bin/sh

filepath=`readlink -f $0`
dirpath=`dirname $filepath`

ln -snf $dirpath/.gitconfig ~/
ln -snf $dirpath/.screenrc ~/
ln -snf $dirpath/.vim ~/
ln -snf $dirpath/.vimrc ~/
ln -snf $dirpath/.zshrc ~/

curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh
