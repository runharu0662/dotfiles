# macOSホストには日常のCLI・エディタ・GUIのみを導入する。
# 新規のプロジェクト依存は原則コンテナ側へ置く。
# 既存Neovimと、その依存の可能性があるツールは今回変更しない。
# REVIEW: fzf / jq / git-delta / lsd はNeovimの間接利用を否定できないため維持する。

# --- Tap sources ---
tap "jesseduffield/lazygit"

# --- Core CLI tools ---
brew "neovim"
brew "git"
brew "ripgrep"
brew "fd"
brew "lsd"

# --- Interactive CLI / Git Tools ---
brew "lazygit"       # TUI Gitクライアント
brew "git-delta"     # git diff viewer (better diff)
brew "fzf"           # fuzzy finder (Neovimでも使える)

# --- Clipboard / Image / Utility ---
brew "pngpaste"      # 画像貼り付け
brew "jq"            # JSON CLI parser

# --- Container runtime ---
brew "colima"
brew "docker"
brew "docker-compose"

# --- Cask GUI Tools ---
cask "loop"
cask "wezterm@nightly"
# REVIEW: Neovimの入力・ノート操作に関わる可能性があるため維持する。
cask "karabiner-elements"
cask "obsidian"
cask "font-hack-nerd-font"
