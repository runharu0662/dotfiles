#!/bin/bash

DOTFILES_DIR=~/dotfiles

DOT_FILES=(.zshrc .hammerspoon)
CONFIG_FILES=(nvim-alt wezterm yabai skhd karabiner)

for file in "${DOT_FILES[@]}"; do
    rm -rf "$HOME/$file"
    ln -sv "$DOTFILES_DIR/$file" "$HOME/$file"
done

mkdir -p "$HOME/.config"
for file in "${CONFIG_FILES[@]}"; do
    rm -rf "$HOME/.config/$file"
    ln -sv "$DOTFILES_DIR/.config/$file" "$HOME/.config/$file"
done