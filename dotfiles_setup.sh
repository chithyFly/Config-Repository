#!/usr/bin/env bash

# Set the source and destination directories
dotfiles_dir="$HOME/dotfiles"
destination_dir="$HOME"

# Suppose current dirctory is dotfiles repo root
if [[ ! -d "$dotfiles_dir" ]]; then
	echo "Dotfiles directory not found: $dotfiles_dir"
	exit 1
fi

cd "$dotfiles_dir" || exit 2

for file in .bashrc .tmux.config .vim .vimrc; do
    ln -sf "$dotfiles_dir/$file" "$destination_dir/$file"
done

echo "Dotfiles setup completed!"
