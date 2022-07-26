#!/bin/bash
#
# No Ansible For Old Men
#

export VRBO_ROOT=/dev/shm/glyn-home

cfg_fzf() {
    echo wat
}

cfg_vim() {
    echo wat
}

cfg_tmux() {
    echo wat
}

cfg_env() {
    echo wat
    mkdir -p $VRBO/{bin,etc,var,run,tmp}

    export PATH=$PATH:$VRBO/bin
}

cfg_scripts() {
    echo "Copy a subset from private ~/etc repo"
    echo "Hmm should I make this a subrepo of ~/etc/? and then just symlink?"
}


main() {
    cfg_env
    cfg_fzf
}


