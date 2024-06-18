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
# eg. key:true
declare -A donfig_file_set
donfig_file_set[".vim"]=1
donfig_file_set[".vimrc"]=1
donfig_file_set[".bashrc"]=1
donfig_file_set[".tmux.conf"]=1

# Only iterate all hidden files(exclusive . and ..)
for f in .*; do
    # Only enforce soft link for files in set
    if [[ -e "$f" ]] && [[ "$donfig_file_set[$f]" ]]; then
        ln -sf "$dotfile_dir/$f" "$destination_dir/$f"
    fi
done

echo "dotfiles setup completed!"
