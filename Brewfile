# macOSホストには日常のCLI・エディタ・GUIと、LSP用のGo・Node.jsを導入する。
# 新規のプロジェクト依存は原則コンテナ側へ置く。
# アプリの実行・ビルド・テストはDocker、ホストのGo・Node.jsは解析とツール導入用。
# REVIEW: fzf / jq / git-delta / lsd はNeovimの間接利用を否定できないため維持する。

# --- Tap sources ---
tap "jesseduffield/lazygit"

# --- Core CLI tools ---
brew "neovim"
brew "tree-sitter-cli"   # nvim-treesitter のパーサー生成
brew "deno"             # skkeleton / denops の日本語入力
brew "git"
brew "ripgrep"
brew "fd"
brew "lsd"

# --- Host dependencies for Neovim language tools ---
# LSP自体はMasonで管理する。formulaのバージョンは固定しない。
brew "go"              # gopls の導入・解析 / gofmt
brew "node"            # Node系LSPの実行・導入（npmを含む）

# --- Interactive CLI / Git Tools ---
brew "gh"            # GitHub CLI
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
