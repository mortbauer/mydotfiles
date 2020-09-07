#!/bin/bash

# tmux
echo 'Bootstrap tmux'
pushd base/
git clone https://github.com/gpakosz/.tmux.git
popd

# vim
echo 'Bootstrap vim'
pushd base/.config/vim/
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
popd
