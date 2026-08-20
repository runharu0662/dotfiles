# My Dotfiles

My personal dotfiles for macOS, managed for quick and easy setup on a new machine.

## 理念

- **ミニマル:** 設定に直接関係するファイルのみを管理します。
- **自動化:** 新しいマシンでのセットアップを可能な限り自動化します。
- **ポータブル:** どのMacでも同じ環境を再現できるようにします。

## 新しいMacでのセットアップ手順

新しいmacOS環境では、リポジトリを取得してインストーラーを実行します。

### 1. Xcode Command Line Tools

未導入の場合は、先に次のコマンドを実行します。

```bash
xcode-select --install
```

`install.sh`から起動することもできます。その場合、インストール完了後に
`install.sh`をもう一度実行してください。

### 2. リポジトリのクローン

このdotfilesリポジトリをホームディレクトリにクローンします。
`nvim-alt`サブモジュールも同時に取得するため、`--recurse-submodules`を付けます。

```bash
git clone --recurse-submodules https://github.com/runharu0662/dotfiles.git ~/dotfiles
```

このフラグを忘れても、`install.sh`がサブモジュールを初期化します。

### 3. セットアップ

`install.sh`はHomebrew、`Brewfile`のツール、Oh My Zsh、テーマ、プラグインを導入し、
設定ファイルのシンボリックリンクを作成します。
既存の設定がある場合は削除せず、`~/.dotfiles-backup/<実行日時>/`へ退避します。

```bash
cd ~/dotfiles
./install.sh
```

インターネットから取得したインストールスクリプトは、実行前に内容を確認してください。
処理は再実行可能で、すでに導入済みの構成要素はそのまま利用します。

## リポジトリの構成

- **`.zshrc`, `.config/`, etc.:** 各種設定ファイルの実体。
- **`install.sh`:** 必要なツールを導入し、設定ファイルのシンボリックリンクを作成するスクリプト。
- **`Brewfile`:** Homebrewで管理するパッケージのリスト。
- **`.gitmodules`:** `nvim-alt`などのサブモジュールを管理するファイル。
