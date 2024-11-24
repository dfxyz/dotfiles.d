#!/usr/bin/bash

cd $(dirname "$0")

if [[ -z $1 ]]; then
    ln -sf $PWD/common/.* ~/
    mkdir -p ~/.vim/pack/default/
    ln -sf $PWD/common/vimpack ~/.vim/pack/default/start
fi
