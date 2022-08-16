# dotfiles

This is how I keep all my configuration files synched across machines. It was
inspired by a [blog
post](https://rafaelc.org/tech/p/a-way-to-organize-your-bash-aliases-on-multiple-hosts/)
(see pdf in this repository).

## Quickstart
Just run the `link_dotfiles.sh` script.

## Dependencies for my setup
 - [fzf](https://github.com/junegunn/fzf)
 - [fd](https://github.com/sharkdp/fd#benchmark)
 - [ag](https://github.com/ggreer/the_silver_searcher)
 - [bat](https://github.com/sharkdp/bat)
 - xclip
 - tmux
 - zathura
 - flake8 (pip3 install flake8)
 - black (pip3 install black)

## To make this work

1) Clone this repository into your home directory (you should then have a
dotfiles directory):

```shell
git clone https://github.com/Matt-A-Bennett/dotfiles.git
```

2) Rename files in the \*\_multihost directories to match the hostnames of your
machines (leave base as is). Fill in the base and system specific
configuration files how you like them.

3) (Optional, but recommended!) Make a backup of your .bashrc, .inputrc, and
any other configuration files that you plan to keep synched across machines
(alternatively you would have to delete them...):
```shell
cd ~/
mv .bashrc .old_bashrc
mv .inputrc .old_inputrc
mv .vimrc .old_vimrc
mv .tmux.conf .old_tmux.conf
mv ~/.ipython/profile_default/ipython_config.py ~/.ipython/profile_default/old_ipython_config.py
```

4) Replace .bashrc, .inputrc, and any other configuration files/directories
that you want to keep synched across machines with symbolic links from your
/home/user directory like so:

```shell
ln -s ~/dotfiles/bashrc_multihost/base .bashrc
ln -s ~/dotfiles/inputrc .inputrc
ln -s ~/dotfiles/tmux.conf .tmux.conf
ln -s ~/dotfiles/tmux_light.conf .tmux_light.conf
ln -s ~/dotfiles/tmux_dark.conf .tmux_dark.conf
ln -s ~/dotfiles/fdignore .fdignore
mkdir -p ~/.config/zathura/zathurarc
ln -s ~/dotfiles/zathurarc ~/.config/zathura/zathurarc
mkdir -p dotfiles/.vim/{backup,undo,swap}
ln -s ~/dotfiles/vimrc .vimrc
ln -sd ~/dotfiles/.vim/after ~/.vim/after
mkdir -p ~/.vim/ultisnips
ln -sd ~/dotfiles/ultisnips ~/.vim/ultisnips
mkdir ~/.w3m
ln -s ~/dotfiles/w3m/keymap ~/.w3m/keymap
ln -s ~/dotfiles/w3m/config ~/.w3m/config
ln -s ~/dotfiles/w3m/functions_info.txt ~/.w3m/functions_info.txt 
mkdir -p ~/.config/bat;
ln -s ~/dotfiles/bat_config ~/.config/bat/config
mkdir -p ~/.ipython/profile_default/;
ln -s ~/dotfiles/ipython_config.py ~/.ipython/profile_default/ipython_config.py
```

Note that I am intentionally making the files that I link to non-hidden. This
is so that they show up when I search for them using fzf [(see below)](#fzf).

### Ultisnips
I use [Ultisnips](https://github.com/SirVer/ultisnips) in Vim, which stores the
snippets in ~/.vim/ultisnips

In order to keep my .snippets files synched across machines, I keep my ultisnip
directory in the ~/dotfiles and create a symbolic link to it from
~/.vim/ultsnips

```shell
ln -sd ~/dotfiles/ultisnips ~/.vim/ultisnips
```
### FZF
I use [fzf](https://github.com/junegunn/fzf) both as a command line tool and
from within Vim using the [fzf.vim
plugin](https://github.com/junegunn/fzf.vim). I configured it to use
[fd](https://github.com/sharkdp/fd#benchmark) in order to respect .fdignore
files.

Sometimes I want to jump to a file in another directory, and I don't want to
have to specify the path for fzf. My solution is to configure fzf to always
search a certain set of directories (and all their subdirectories) in my home
directory (I only have about 15 or so containing ~5000 files that I would want
to search, so this can certainly be handled by
[fd](https://github.com/sharkdp/fd#benchmark). This way, no
matter where I am in my file system, I can always find the file I want without
thinking about where it is

I created a .fdignore file in my home directory. The .fdignore file should be
symbolically linked to a file in the dotfiles repository [like in the steps
above](#to-make-this-work)

```shell
ln -s ~/dotfiles/fdignore .fdignore
```

Then in your .bashrc, add the following line (already added for the .bashrc in
this repository):
```shell
export FZF_DEFAULT_COMMAND="fd . $HOME"
```

If you're using Ubuntu 19.10 or later, and have installed fd using sudo apt,
then the above line needs to be modified like so:
```shell
export FZF_DEFAULT_COMMAND="fdfind . $HOME"
```

Then in the fdignore file, I first list all my home directories, each
followed by a '/':
```shell
# start by igoring every home directory
anaconda3/
arch/
cache/
code/
Desktop/
  .
  .
  .
```

Then **below** those, put the directories that you want to be searched, each
preceded by a '!' and followed by a '/':

```shell
# now un-ignore the ones I care about
!code/
!Desktop/
!documents/
!downloads/
  .
  .
  .
```

The '!' will 'cancel out' the previous ignore commands.

N.B. I have noticed that, for some reason, a couple of subdirectories were not
showing up in the fzf search, and so I explicitly created some
'!path/to/missed/directory/' lines in this section...

If you're doing this across multiple machines, you can make a separate home
directory list per machine in the fdignore file (it doesn't matter if
some directories don't exist on some machines, or if some directories are
repeated between lists). Then after all those, add a single list of directories
you want to search across any machine.

If you're using Vim to create the fdignore file, an easy way to get a
list of all the directories in your home directory is the following command:
```shell
:.!ls ~/
```

Append a '/' to all lines by putting the cursor on the first directory in the
list and entering the following command:
```shell
:.,$ norm A/
```

Now you can just copy the directories that you do want to search, and place
them **below** with a '!' preceding them.

Similar to above, insert the '!' before each one by putting the cursor on the
first directory in the list and entering the following command:
```shell
:.,$ norm I!
```
