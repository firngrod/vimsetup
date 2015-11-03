#!/bin/bash
rm -rf ~/.vim ~/.vimrc
ln -s ~/vimsetup ~/.vim
ln -s ~/vimsetup/.vimrc ~/.vimrc
cd ~/vimsetup
git submodule init
git submodule update

