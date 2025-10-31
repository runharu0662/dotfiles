#!/bin/bash

DOTFILES_DIR=~/dotfiles
# Array of files/dirs to symlink directly in ~
DOT_FILES=(.zshrc .hammerspoon)
# Array of files/dirs to symlink in ~/.config
CONFIG_FILES=(nvim-alt wezterm yabai skhd karabiner)

# Symlink files in home directory
for file in "${DOT_FILES[@]}"; do
    rm -rf "$HOME/$file"
    ln -sv "$DOTFILES_DIR/$file" "$HOME/$file"
done

# Symlink files in .config directory
mkdir -p "$HOME/.config"
for file in "${CONFIG_FILES[@]}"; do
    rm -rf "$HOME/.config/$file"
    ln -sv "$DOTFILES_DIR/.config/$file" "$HOME/.config/$file"
done