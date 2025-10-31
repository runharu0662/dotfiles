# My Dotfiles

My personal dotfiles for macOS, managed for quick and easy setup on a new machine.

## 理念

- **ミニマル:** 設定に直接関係するファイルのみを管理します。
- **自動化:** 新しいマシンでのセットアップを可能な限り自動化します。
- **ポータブル:** どのMacでも同じ環境を再現できるようにします。

## 新しいMacでのセットアップ手順

新しいmacOS環境をセットアップするには、以下の手順に従ってください。

### 1. 前提ツールのインストール

#### Homebrew

macOSのパッケージマネージャーである[Homebrew](https://brew.sh/index_ja)をインストールします。

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### Oh My Zsh

Zshのフレームワークである[Oh My Zsh](https://ohmyz.sh/)をインストールします。

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 2. Dotfilesの適用

#### リポジトリのクローン

このdotfilesリポジトリをホームディレクトリにクローンします。

```bash
git clone https://github.com/runharu0662/dotfiles.git ~/dotfiles
```
**注意:** `runharu0662`の部分は、ご自身のGitHubユーザー名に置き換えてください。

#### 設定の適用

`install.sh`スクリプトを実行して、設定ファイルのシンボリックリンクを作成します。

```bash
cd ~/dotfiles
./install.sh
```

### 3. ソフトウェアのインストール

`Brewfile`を使って、必要なソフトウェアを一括でインストールします。

```bash
brew bundle install
```

これで、以前の環境と同じ設定とツールがすべて揃います。

## リポジトリの構成

- **`.zshrc`, `.config/`, etc.:** 各種設定ファイルの実体。
- **`install.sh`:** ホームディレクトリに設定ファイルのシンボリックリンクを作成するスクリプト。
- **`Brewfile`:** Homebrewで管理するパッケージのリスト。
