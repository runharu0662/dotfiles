#!/usr/bin/env bash

# --- Dock ---
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock launchanim -bool false
defaults write com.apple.dock mineffect -string "scale"
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock mru-spaces -bool false

# --- Screenshot ---
defaults write com.apple.screencapture target -string "clipboard"

# --- Safari shortcuts ---
defaults write com.apple.Safari NSUserKeyEquivalents -dict \
  "タブを閉じる" "^w" \
  "ページを再読み込み" "^r" \
  "前のタブグループへ移動" "^k" \
  "新規タブ" "^t" \
  "次のタブグループへ移動" "^j"

killall Dock 2>/dev/null || true
