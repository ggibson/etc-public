#!/bin/bash

# stopgap while i reorganize around chezmoi/stow/etc.

main() {
    ln -s $(pwd)/../configs/vim/vimrc ~/.vimrc
}


main
