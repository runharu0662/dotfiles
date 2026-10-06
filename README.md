# dotfiles

macOS用の設定とアプリのインストール構成。

## セットアップ

Command Line Toolsをインストールし、完了後に実行する。

```sh
xcode-select --install
git clone --recurse-submodules https://github.com/runharu0662/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

Brewfileのパッケージを導入し、設定をリンクする。
既存設定は`~/.dotfiles-backup/`へ退避する。

## Loop

Loopを終了してから、リポジトリ直下で設定を復元する。

```sh
defaults import com.MrKai77.Loop "$PWD/.config/loop/com.MrKai77.Loop.plist"
open -a Loop
```

現在の設定を保存する場合：

```sh
defaults export com.MrKai77.Loop "$PWD/.config/loop/com.MrKai77.Loop.plist"
```
