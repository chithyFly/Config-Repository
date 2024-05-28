#!/usr/bin/env bash

# Enable extend globing
shopt -s extglob

# Set the source and destination directories
dotfile_dir="$HOME/dotfiles"
destination_dir="$HOME"

if [[ ! -d "$dotfile_dir" ]]; then
	echo "dotfiles directory not found: $dotfile_dir"
	exit 1
fi

cd "$dotfile_dir" || exit 2

# Declare a hash map for config files (in genreal like hash set)
declare -A configFiles
configFiles[".vim"]=1
configFiles[".vimrc"]=1
configFiles[".bashrc"]=1
configFiles[".tmux.conf"]=1

# Only iterate all hidden files(exclusive . and ..)
for f in .*; do
    if [[ -e "$f" ]] && [[ "${configFiles[${f}]}" ]]; then
        ln -sf "$dotfile_dir/$f" "$destination_dir/$f"
    fi
done

echo "dotfiles setup completed!"
