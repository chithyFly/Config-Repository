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
declare -A config_files
config_files[".vim"]=1
config_files[".vimrc"]=1
config_files[".bashrc"]=1
config_files[".tmux.conf"]=1
config_files[".vim"]=1

# Only iterate all hidden files(exclusive . and ..)
for f in .*; do
    # Only enforce soft link for files in config_files
    if [[ -e "$f" ]] && [[ "${config_files[$f]}" ]]; then
        ln -sf "$dotfile_dir/$f" "$destination_dir/$f"
    fi
done

echo "dotfiles setup completed!"
