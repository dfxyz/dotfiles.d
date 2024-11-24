#!/usr/bin/bash

cd $(dirname "$0")

dotfiles=$(ls $PWD/common/.*)

for file in $dotfiles; do
    if [[ -f $file ]]; then
        ln -sf $file ~/
    fi
done

mkdir -p ~/.vim/pack/default/
[[ -e ~/.vim/pack/default/start ]] && rm -rf ~/.vim/pack/default/start
ln -sf $PWD/common/vimpack ~/.vim/pack/default/start
