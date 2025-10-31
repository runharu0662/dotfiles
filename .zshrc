
# =========================
#  Basic shell guard
# =========================
# 対話シェルでのみ下を実行（scp等の非対話で暴走しない）
case $- in
  *i*) ;;
  *) return;;
esac

# =========================
#  PATH（Apple Silicon）
# =========================
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

# =========================
#  Locale
# =========================
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# =========================
#  oh-my-zsh / theme
# =========================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# =========================
#  Tools
# =========================
# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Neovim
export NVIM_APPNAME="nvim-alt"
export GIT_EDITOR="nvim"

# z (jump)
[ -f ~/z/z.sh ] && . ~/z/z.sh

# =========================
#  Secrets (別ファイル)
# =========================
# ~/.config/env.d/secrets.env にAPIキー等を退避（後述）
if [ -f "$HOME/.config/env.d/secrets.env" ]; then
  set -a
  source "$HOME/.config/env.d/secrets.env"
  set +a
fi

# =========================
#  Aliases
# =========================
alias ls='lsd'                 # 見やすい ls
alias lst='lsd --tree'
alias gita='git add .'
alias gitc='git commit -m'
alias gitp='git push'
alias code='nvim'

# =========================
#  Functions
# =========================
# WezTerm を現在/指定ディレクトリで開く（必要な時だけ起動）
wez() { open -na WezTerm --args start --cwd "${1:-$PWD}"; }

# 便利：Obsidian Vault へ移動して nvim 起動
ob() {
  cd /Users/ishiiharuta/Documents/Obsidian_Vaults/Obsidian_Vault1 || return
  nvim
}
# あなたの独自コマンド（そのまま残し）
splup () { python ~/app/s3s/s3s.py -M 60 -r -nsr; }
daily() { cd ~/dev/cpp && git add . && git commit -m auto && gitp && cd; }
start() { ~/dev/script/windows.sh; }

# =========================
#  Final
# =========================
# ここに「open -a WezTerm .」のような自動起動は置かないこと！

