#!/bin/bash
#
# No Ansible For Old Men
#

export VRBO=/dev/shm/glyn-home
export VRBO_TMP=/tmp/vrbo

export OLDHOME=/home/netskrt

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

vrbo_cfg_bat() {
    echo Setup bat
    wget https://github.com/sharkdp/bat/releases/download/v0.21.0/bat-v0.21.0-x86_64-unknown-linux-gnu.tar.gz -O $VRBO_TMP/bat.tar.gz
    tar xzvf $VRBO_TMP/bat.tar.gz -C $VRBO_TMP
    mv $VRBO_TMP/bat-v0.21.0-x86_64-unknown-linux-gnu/bat $VRBO/bin
}

vrbo_cfg_tmux() {
    echo wat
}

vrbo_cfg_env() {
    echo Configuing VRBO environment
    mkdir -p $VRBO/{bin,etc,var,run,tmp}
    mkdir -p $VRBO_TMP


    echo 'export PATH=$PATH:$VRBO/bin' >> $VRBO/.bashrc
}

vrbo_cfg_scripts() {
    echo "Copy a subset from private ~/etc repo"
    echo "Hmm should I make this a subrepo of ~/etc/? and then just symlink?"
}

vrbo_import() {
    # NB: can't run this if you've switch path already
    echo "Importing settings from existing user"

    cp -r ~/.kube $VRBO
    cp -r ~/.aws $VRBO
    cp -r ~/.docker $VRBO
}

vrbo_docker() {

    # docker-compose:  do this
    # - https://docs.docker.com/compose/install/compose-plugin/#install-the-plugin-manually
    echo wot
}


vrbo_main() {
    cfg_env
    cfg_fzf
}

vrbo_sh() {
    export OLD_HOME=$HOME
    export PATH=$PATH:$VRBO/bin
    HOME=$VRBO /bin/bash
}


