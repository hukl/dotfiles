dotfiles
========

Collection of various config files, stolen from hukl, modified to my needs.

## General Setup
clone the repository to a location of your choice and link .zshrc, vim.rc, .zsh to your home home-directory.


    DOTFILES_DIR="~/dotfiles"
    ln -s $DOTFILES_DIR/.zsh ~/
    ln -s $DOTFILES_DIR/.zshrc ~/
    ln -s $DOTFILES_DIR/.vimrc ~/
    ln -s $DOTFILES_DIR/.zlogin ~/

    mkdir ~/.vimbackup

i am leaving out *.git* and *.gitmodules* on purpose right now, since i havent cleaned them up yet.


## Vim

run ```git submodule init && git submodule update``` before starting vim.


## For *sudoers*

in case you want to use `sudo` it is a good idea to do all that again for the root user.
