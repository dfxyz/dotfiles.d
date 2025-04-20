#!/usr/bin/bash

if [[ $OS == "Windows_NT" ]]; then
    TARGET_DIR=$HOME/AppData/Roaming/mpv
else
    TARGET_DIR=$HOME/.config/mpv
fi
if [[ -d "$TARGET_DIR" ]]; then
    echo "WARNING: Target directory already exists, abort copying files."
fi
mkdir -p "$TARGET_DIR"

cd $(dirname "$0")
cp -r ./mpv/* "$TARGET_DIR"
