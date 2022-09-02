#!/bin/bash
 
sudo apt -y install vim-gtk3 
sudo apt -y install tmux
sudo apt -y install install texlive-latex-extra
sudo apt -y install pandoc
sudo apt -y install zathura 
sudo apt -y install bat
sudo apt -y install xclip
sudo apt -y install htop
sudo apt -y install silversearcher-ag

sudo apt -y install fd

# if the last command failed, try this different one
if [[ $? > 0 ]]
then
    sudo apt -y install fd-find
fi

# clone and install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf 
~/.fzf/install

# clone and install vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
 
