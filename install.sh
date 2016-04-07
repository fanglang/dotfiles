#!/bin/sh

dirpath=$(cd $(dirname $0) && pwd)

ln -snf $dirpath/.gitconfig ~/
ln -snf $dirpath/.tmux.conf ~/
ln -snf $dirpath/.vim ~/
ln -snf $dirpath/.vimrc ~/
ln -snf $dirpath/.zshrc ~/

curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh
