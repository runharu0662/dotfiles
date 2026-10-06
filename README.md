# Mac dotfiles

初期化したMacから、最小限・理解可能・再現可能な作業環境を復元する。
主要ツールはLoop、WezTerm、macOS標準Zsh、Neovim。新規の言語ランタイム・DB・
ミドルウェアはプロジェクトのDocker / Dev Container側で管理する。
ローカル実行環境としてColimaとDocker CLI、ComposeをBrewfileから導入する。

**既存Neovim環境は例外として保持する。** `.config/nvim-alt`のサブモジュール、
plugin、Mason、LSP、formatter、linter、入力環境、その依存関係は整理対象外。
`NVIM_APPNAME=nvim-alt`と既存の導入・リンク方式も維持する。
Brewfileはバージョンの完全固定ではなく、導入対象を管理する。

## 初期化後の復元

1. `xcode-select --install`でCommand Line Toolsを導入し、完了を待つ。
2. リポジトリを取得する。

   ```sh
   git clone --recurse-submodules https://github.com/runharu0662/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ./install.sh
   ```

3. 新しいWezTerm / Zshを開き、Loopを起動してアクセシビリティ権限を許可する。
4. 下記の手動確認を行う。macOS本体の設定は手動で行う。

`install.sh`はHomebrewとBrewfileのツールを導入し、
Neovimサブモジュールの`origin/web`最新版を取得し、`web`ブランチに切り替えて設定をリンクする。
既存の`web`ブランチはfast-forwardで更新し、履歴が分岐していれば停止する。
既存Homebrewは標準パスからも検出する。既存設定は
`~/.dotfiles-backup/<実行日時>/`へ退避し、同じリンクは再利用する。
CLTがなければインストーラーを起動して終了するため、完了後に再実行する。
Homebrew導入スクリプトの内容は実行前に確認する。

Gitのorigin URL、Git本人情報、認証設定は自動変更しない。
macOS defaultsも自動適用しない。アプリ・パッケージのアンインストールは行わない。

## 構成と責務

| ファイル | 責務 |
| --- | --- |
| `Brewfile` | ホストの導入対象。Neovim関連の可能性がある既存依存も保持 |
| `install.sh` | 導入・バックアップ・明示した設定のリンク |
| `.zshrc` | Homebrew PATH、履歴、補完、基本options、標準prompt |
| `.config/wezterm/` | ターミナルの外観・キー操作 |
| `.config/nvim-alt` / `.gitmodules` | Neovimの`web`ブランチを導入・追跡 |
| `.config/karabiner/` | 現在使用中のキーボード・入力変換設定とルール素材を保存 |

PATH初期化は`.zshrc`に集約し、ログイン・非ログインの対話シェルで使用する。
既存PATHの要素は保持し、Homebrewを優先して重複を除く。
Zshは標準のhistory、completion、基本optionsとシンプルなpromptだけを使う。
Oh My Zsh、Powerlevel10k、autosuggestions、syntax-highlightingは導入・読込しない。
alias / functionは設けず、必要になった機能だけ後から`.zshrc`へ追加する。
履歴は`~/.zsh_history`に保存・共有する。補完は標準`compinit`、キー操作はEmacs方式。
Neovim用の`NVIM_APPNAME`、`GIT_EDITOR`と既存ロケールは保持する。

## macOS本体の設定

macOS defaultsは管理・適用しない。`macos.sh`は削除した。
Dock、Safari、スクリーンショット、Finder、キーボード、トラックパッド等は
実際に使ってから必要な項目を手動で設定する。
過去に適用した設定を自動で元に戻す処理も行わない。

## 手動確認・REVIEW

- Loop: トリガーキー、左右半分・最大化・画面移動、ログイン時起動を設定する。
  Loop設定の保存・復元方式は未確定のため、今回は自動適用しない。
- AeroSpace / yabai: 既存アプリがあれば終了し、ログイン項目を無効にする。
  installerは、このリポジトリを直接指す旧AeroSpaceリンクのみ退避する。
  他の場所を指すリンクや個人の設定には触れない。
- Tailscale: 新規導入対象から外した。既存インストールは削除しない。
- Karabiner: キーボード別修飾キー変更・Ctrl+[の日本語入力切替を確認する。
  必要なら権限を許可する。`~/.config/karabiner`で現在使用中の設定・ルール素材を保存済み。
- Neovim: `nvim`、`:checkhealth`、検索、SKK、日本語入力、画像貼付け、
  LSP・補完・Copilotが従来どおり使えるか確認する。関連依存を削除しない。
- WezTerm: workspace作成、ペイン操作、copy modeでのEnter、日本語IMEを確認する。
- Zsh: `command -v brew git nvim`でHomebrew優先を確認する。
  履歴保存・補完・promptを確認する。テーマ・pluginの復元は不要。
  既存の`.zprofile` / `.zshenv`等が旧フレームワークを読み込んでいないか確認する。
- Git: `git config --global user.name` / `user.email`、HTTPSまたはSSH認証を設定する。
- `fzf` / `jq` / `git-delta` / `lsd`、Obsidian: Neovimの利用可能性があるため維持する。
  `pngpaste` / `lazygit` / `ripgrep` / `fd` / Nerd Fontは既存Neovim向けに維持する。
- WezTerm nightly: 現設定との互換性確認までは継続する。
- Colima: 導入後、新しいZshで`colima start`を実行してDockerエンジンを起動する。
  初回起動にはVMイメージ等のダウンロードが発生する。停止は`colima stop`。
  Composeを`docker compose`で使うため、`~/.docker/config.json`の
  `cliPluginsExtraDirs`配列に`$(brew --prefix)/lib/docker/cli-plugins`の実際のパスを追加する。
  Apple Siliconの標準Homebrewでは次の設定になる。既存JSONの他の項目は保持する。

  ```json
  {
    "cliPluginsExtraDirs": ["/opt/homebrew/lib/docker/cli-plugins"]
  }
  ```

  エンジン起動後、`docker version`、`docker compose version`、
  `docker run --rm hello-world`を確認する（イメージのダウンロードが発生する）。
  プロジェクトの言語・DB等はDockerfile / Compose / Dev Containerで管理する。
  手順の参照: [Colima公式](https://github.com/abiosoft/colima)、
  [Homebrew Compose設定](https://formulae.brew.sh/formula/docker-compose)。

Brewfileから外した項目を理由に`brew bundle cleanup`を実行しない。
現Brewfileに未記載でもNeovimが使うランタイム・辞書・ビルド依存があり得る。
新MacでのNeovim全機能の復元は、それらの手動確認を含む。
