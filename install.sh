#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'
umask 077

readonly DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
readonly BACKUP_DIR="$HOME/.dotfiles-backup/$(date '+%Y%m%d-%H%M%S')"

if [[ "$(uname -s)" != "Darwin" ]]; then
  printf 'Error: this installer supports macOS only.\n' >&2
  exit 1
fi

if ! xcode-select -p >/dev/null 2>&1; then
  printf 'Xcode Command Line Tools are required. Starting the installer...\n'
  xcode-select --install
  printf 'After installation finishes, run this script again.\n'
  exit 0
fi

install_homebrew() {
  local installer

  if command -v brew >/dev/null 2>&1; then
    return
  fi

  command -v curl >/dev/null 2>&1 || {
    printf 'Error: curl is required to install Homebrew.\n' >&2
    return 1
  }

  installer="$(mktemp "${TMPDIR:-/tmp}/homebrew-install.XXXXXX")"
  trap 'rm -f -- "$installer"' RETURN
  curl --proto '=https' --tlsv1.2 --fail --silent --show-error \
    --location --output "$installer" \
    'https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh'
  NONINTERACTIVE=1 /bin/bash "$installer"
  rm -f -- "$installer"
  trap - RETURN

  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  else
    printf 'Error: Homebrew installation did not create a brew executable.\n' >&2
    return 1
  fi
}

clone_if_missing() {
  local repository="$1"
  local destination="$2"

  if [[ -d "$destination/.git" ]]; then
    printf 'Already installed: %s\n' "$destination"
    return
  fi
  if [[ -e "$destination" || -L "$destination" ]]; then
    printf 'Error: refusing to replace existing path: %s\n' "$destination" >&2
    return 1
  fi

  git clone --depth=1 -- "$repository" "$destination"
}

install_homebrew

git -C "$DOTFILES_DIR" submodule update --init --recursive
brew bundle --file="$DOTFILES_DIR/Brewfile"

readonly ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
clone_if_missing 'https://github.com/ohmyzsh/ohmyzsh.git' "$HOME/.oh-my-zsh"
mkdir -p -- "$ZSH_CUSTOM/themes" "$ZSH_CUSTOM/plugins"
clone_if_missing 'https://github.com/romkatv/powerlevel10k.git' \
  "$ZSH_CUSTOM/themes/powerlevel10k"
clone_if_missing 'https://github.com/zsh-users/zsh-autosuggestions.git' \
  "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
clone_if_missing 'https://github.com/zsh-users/zsh-syntax-highlighting.git' \
  "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

# このリポジトリの GitHub HTTPS remote だけを SSH に変更する。
if remote_url="$(git -C "$DOTFILES_DIR" remote get-url origin 2>/dev/null)" &&
  [[ "$remote_url" =~ ^https://github\.com/([^/]+)/([^/]+)(\.git)?$ ]]; then
  repo_path="${BASH_REMATCH[1]}/${BASH_REMATCH[2]}"
  repo_path="${repo_path%.git}"
  ssh_url="git@github.com:${repo_path}.git"
  git -C "$DOTFILES_DIR" remote set-url origin "$ssh_url"
  printf 'Changed remote URL to SSH: %s\n' "$ssh_url"
fi

backup_and_link() {
  local source_path="$1"
  local target_path="$2"
  local backup_path

  [[ -e "$source_path" || -L "$source_path" ]] || {
    printf 'Error: source does not exist: %s\n' "$source_path" >&2
    return 1
  }

  if [[ -L "$target_path" && "$(readlink "$target_path")" == "$source_path" ]]; then
    printf 'Already linked: %s\n' "$target_path"
    return
  fi

  if [[ -e "$target_path" || -L "$target_path" ]]; then
    backup_path="$BACKUP_DIR/${target_path#"$HOME"/}"
    mkdir -p -- "$(dirname -- "$backup_path")"
    chmod 700 "$BACKUP_DIR"
    mv -- "$target_path" "$backup_path"
    printf 'Backed up: %s -> %s\n' "$target_path" "$backup_path"
  fi

  mkdir -p -- "$(dirname -- "$target_path")"
  ln -s -- "$source_path" "$target_path"
  printf 'Linked: %s -> %s\n' "$target_path" "$source_path"
}

dot_files=(.zshrc .hammerspoon)
config_files=(nvim-alt wezterm karabiner aerospace)

for file in "${dot_files[@]}"; do
  backup_and_link "$DOTFILES_DIR/$file" "$HOME/$file"
done

for file in "${config_files[@]}"; do
  backup_and_link "$DOTFILES_DIR/.config/$file" "$HOME/.config/$file"
done
