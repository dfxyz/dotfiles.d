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
ln -s $PWD/common/vimpack ~/.vim/pack/default/start

[[ -e ~/.scripts ]] && rm ~/.scripts
ln -s $PWD/common/scripts ~/.scripts
