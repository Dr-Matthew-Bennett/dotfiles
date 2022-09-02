#!/bin/bash

# # replace configuration files/directories with symbolic links from your
ln -s $@ ~/dotfiles/bashrc_multihost/base ~/.bashrc
ln -s $@ ~/dotfiles/inputrc ~/.inputrc
ln -s $@ ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s $@ ~/dotfiles/tmux_light.conf ~/.tmux_light.conf
ln -s $@ ~/dotfiles/tmux_dark.conf ~/.tmux_dark.conf
ln -s $@ ~/dotfiles/fdignore ~/.fdignore

mkdir -p dotfiles/.vim/{backup,undo,swap}
ln -s $@ ~/dotfiles/vimrc ~/.vimrc

if [[ ! -e ~/.vim/after ]]; then
    ln -sd $@ ~/dotfiles/.vim/after ~/.vim/after
fi

if [[ ! -e ~/.vim/ultisnips ]]; then
    ln -sd $@ ~/dotfiles/ultisnips ~/.vim/ultisnips
fi

mkdir -p ~/.config/zathura/zathurarc
ln -s $@ ~/dotfiles/zathurarc ~/.config/zathura/zathurarc

mkdir ~/.w3m
ln -s $@ ~/dotfiles/w3m/keymap ~/.w3m/keymap
ln -s $@ ~/dotfiles/w3m/config ~/.w3m/config
ln -s $@ ~/dotfiles/w3m/functions_info.txt ~/.w3m/functions_info.txt 

mkdir -p ~/.config/bat;
ln -s $@ ~/dotfiles/bat_config ~/.config/bat/config

mkdir -p ~/.ipython/profile_default/;
ln -s $@ ~/dotfiles/ipython_config.py ~/.ipython/profile_default/ipython_config.py

