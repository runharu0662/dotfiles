# dotfiles

macOS用の設定とアプリのインストール構成。

## セットアップ

最初にCommand Line Toolsをインストールする。

```sh
xcode-select --install
```

インストール画面で完了を確認してから、ターミナルで実行する。

```sh
git clone --recurse-submodules https://github.com/runharu0662/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

Homebrewがなければ対話形式で導入する。途中の管理者パスワード入力や確認に応答するため、`sudo ./install.sh`ではなく通常のユーザーで実行する。既存のHomebrewはPATHに未登録でも再利用する。

インストーラーはNeovim設定のサブモジュールを`web`ブランチのリモート最新版へ更新し、Brewfileのパッケージを導入する。その後、`.zshrc`と`~/.config/`内の`RigNvim`・`wezterm`・`karabiner`をリンクする。既存設定は`~/.dotfiles-backup/<日時>/`へ退避する。Loopの設定復元は下記の手順で別途行う。

完了後はターミナルを開き直すか、次を実行してHomebrewのPATHと`NVIM_APPNAME=RigNvim`を読み込む。

```sh
exec zsh -l
```

旧名`nvim-alt`のデータ・履歴・キャッシュは、移行先が未作成の場合に`RigNvim`へ引き継ぐ。既存ツール内の絶対パスを維持するため、旧データパスには互換リンクを残す。

## Neovimの初回セットアップ

```sh
nvim --version
tree-sitter --version
deno --version
nvim
```

現在の`web`設定はNeovim 0.12以降とtree-sitter CLI 0.26.1以降を前提としている。Brewfileには`neovim`・`tree-sitter-cli`と、日本語入力用の`deno`を含めている。バージョンが不足する場合は`brew update`の後に`brew upgrade neovim tree-sitter-cli`を実行し、再確認する。

初回起動ではプラグインとTreesitterのパーサーを取得するため、ネットワーク接続が必要。`:Lazy`でインストール完了を確認し、パーサーの取得後にファイルを開き直す。エラーが残る場合は`:messages`と`:checkhealth`で確認する。

- 日本語入力：Denoの導入後にNeovimを再起動し、`:Lazy`で`skkeleton`と`denops.vim`を確認する。挿入モードの`Ctrl-j`で切り替える。SKK辞書は設定に同梱されている。
- Copilot：`:Copilot auth`で認証し、`:Copilot status`で確認する。`Space l t`で有効・無効を切り替える。GitHub CLIの`gh auth login`とは別の認証になる。
- LSP・整形：必要なツールだけ`:Mason`などで導入する。Node系のLSPやPrettier・ESLintをホストで使う場合はNode.jsも別途必要。詳しくは[Neovim設定のREADME](.config/RigNvim/README.md)を参照する。

WezTermはnightly版を使用する。Hack Nerd FontはBrewfileで導入し、日本語表示はmacOSのヒラギノへフォールバックする。

## 再セットアップ・更新

```sh
cd ~/dotfiles
git pull --ff-only
./install.sh
```

途中で導入に失敗した場合も、原因を解消して`./install.sh`を再実行できる。同じリンクは作り直さない。Neovimのサブモジュールにローカル変更がある場合は、先にそのディレクトリで`git status`を確認し、変更をコミットまたは退避する。ブランチ切り替えやfast-forward更新に失敗した場合はそこで停止する。

## Loop

Loopを終了してから、リポジトリ直下で設定を復元する。

```sh
defaults import com.MrKai77.Loop "$PWD/.config/loop/com.MrKai77.Loop.plist"
open -a Loop
```

LoopとKarabiner-Elementsを起動し、macOSが求めるアクセシビリティ・入力監視などの権限を許可する。

現在の設定を保存する場合：

```sh
defaults export com.MrKai77.Loop "$PWD/.config/loop/com.MrKai77.Loop.plist"
```
