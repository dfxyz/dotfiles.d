#!/usr/bin/bash

TYPES=(
    "keymaps"
    "codestyles"
)

if [[ $OS == "Windows_NT" ]]; then
    TARGET_DIR="$HOME/AppData/Roaming/JetBrains"
else
    TARGET_DIR="$HOME/.config/JetBrains"
fi

cd $(dirname "$0")
for dir in "$TARGET_DIR"/*/; do
    if [[ "$dir" == *"consentOptions/" ]]; then
        continue
    fi
    for type in ${TYPES[@]}; do
        mkdir -p "$dir$type"
        cp ./jetbrains/$type.xml "$dir$type/DF_XYZ.xml"
    done
done
