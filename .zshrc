# 対話シェルの基本設定のみ管理する。
[[ -o interactive ]] || return

# 既存PATHを保持し、Homebrewを優先。再読み込みでも重複させない。
typeset -U path
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# 既存Neovim環境の起動条件を維持する。
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export NVIM_APPNAME="nvim-alt"
export GIT_EDITOR="nvim"

# 履歴はZsh標準機能で保存・共有する。
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY SHARE_HISTORY HIST_IGNORE_DUPS HIST_REDUCE_BLANKS

# 基本的な対話操作と補完。外部pluginは読み込まない。
setopt AUTO_CD INTERACTIVE_COMMENTS
bindkey -e
autoload -Uz compinit
compinit

# user@host directory %（rootでは#）
PROMPT='%n@%m %~ %# '
RPROMPT=''
