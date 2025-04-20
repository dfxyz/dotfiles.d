#!/usr/bin/bash

if [[ $OS == "Windows_NT" ]]; then
    DIRS=(
        "$HOME/AppData/Roaming/Code/User"
        "$HOME/AppData/Roaming/Cursor/User"
        "$HOME/AppData/Roaming/Windsurf/User"
    )
else
    DIRS=(
        "$HOME/.config/Code/User"
        "$HOME/.config/Cursor/User"
        "$HOME/.config/Windsurf/User"
    )
fi

cd $(dirname "$0")
for dir in ${DIRS[@]}; do
    if [[ -d "$dir" ]]; then
        cp -r ./vscode/* "$dir"
    fi
done
