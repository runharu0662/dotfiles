#!/bin/bash

DOTFILES_DIR=~/dotfiles

brew bundle --file=$DOTFILES_DIR/Brewfile

# Git remote URLをSSHに変更
REMOTE_URL=$(git remote get-url origin)
if [[ $REMOTE_URL == https://* ]]; then
  SSH_URL=$(echo $REMOTE_URL | sed -e 's/https://github.com\//git@github.com:/')
  git remote set-url origin $SSH_URL
  echo "Changed remote URL to SSH: $SSH_URL"
else
  echo "Remote URL is already SSH or not a GitHub HTTPS URL."
fi

DOT_FILES=(.zshrc .hammerspoon)
CONFIG_FILES=(nvim-alt wezterm karabiner aerospace)

for file in "${DOT_FILES[@]}"; do
    rm -rf "$HOME/$file"
    ln -sv "$DOTFILES_DIR/$file" "$HOME/$file"
done

mkdir -p "$HOME/.config"
for file in "${CONFIG_FILES[@]}"; do
    rm -rf "$HOME/.config/$file"
    ln -sv "$DOTFILES_DIR/.config/$file" "$HOME/.config/$file"
done