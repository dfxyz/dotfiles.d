#!/usr/bin/bash

cd $(dirname "$0")

dotfiles=$(ls $PWD/common/.*)

for file in $dotfiles; do
    if [[ -f $file ]]; then
        ln -sf $file $HOME/
    fi
done

mkdir -p $HOME/.vim/pack/default/
[[ -e $HOME/.vim/pack/default/start ]] && rm -rf $HOME/.vim/pack/default/start
ln -s $PWD/common/vimpack $HOME/.vim/pack/default/start

[[ -e $HOME/.scripts ]] && rm $HOME/.scripts
ln -s $PWD/common/scripts $HOME/.scripts
