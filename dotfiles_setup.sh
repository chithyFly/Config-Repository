#!/usr/bin/env bash

# Enable extend globing
shopt -s extglob

# Set the source and destination directories
dotfiles_dir="$HOME/dotfiles"
destination_dir="$HOME"

if [[ ! -d "$dotfiles_dir" ]]; then
	echo "Dotfiles directory not found: $dotfiles_dir"
	exit 1
fi

cd "$dotfiles_dir" || exit 2

# Declare a hash map for config files (in genreal like hash set)
declare -A configFiles
configFiles[".vim"]=1
configFiles[".vimrc"]=1
configFiles[".bashrc"]=1
configFiles[".tmux.conf"]=1

# Only iterate all hidden files(exclusive . and ..)
for f in .*; do
    if [[ -e "$f" ]] && [[ "${configFiles[${f}]}" ]]; then
        ln -sf "$dotfiles_dir/$f" "$destination_dir/$f"
    fi
done

echo "Dotfiles setup completed!"


