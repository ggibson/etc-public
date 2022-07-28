#!/bin/bash
#
# No Ansible For Old Men
#

export VRBO=/dev/shm/glyn-home
export VRBO_TMP=/tmp/vrbo

vrbo_cfg_fzf() {
    echo Setup fzf
    git clone --depth 1 https://github.com/junegunn/fzf.git $VRBO/.fzf
    $VRBO/.fzf/install
}

vrbo_cfg_vim() {
    echo Setup vim
    mkdir -p $VRBO/.vim
    cp vimrc $VRBO/.vim/.vimrc
    ln -s $VRBO/.vim/.vimrc $VRBO/.vimrc
}

vrbo_cfg_tmux() {
    echo wat
}

vrbo_cfg_env() {
    echo Configuing VRBO environment
    mkdir -p $VRBO/{bin,etc,var,run,tmp}
    mkdir -p $VRBO_TMP

    export PATH=$PATH:$VRBO/bin

    echo 'export PATH=$PATH:$VRBO/bin' >> $VRBO/.bashrc
}

vrbo_cfg_scripts() {
    echo "Copy a subset from private ~/etc repo"
    echo "Hmm should I make this a subrepo of ~/etc/? and then just symlink?"
}


vrbo_main() {
    cfg_env
    cfg_fzf
}

vrbo_sh() {
    HOME=$VRBO /bin/bash
}

