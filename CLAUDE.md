# プロジェクトガイド

Laravel 13 + Inertia.js のテンプレートプロジェクト。

## プロジェクト構成

- **Laravel アプリ本体は `htdocs/` 配下**(リポジトリ直下ではない)。
  `app/` `routes/` `resources/` `tests/` などは `htdocs/` 以下にある。
- artisan / composer / npm / pint / test などは **Docker コンテナ内**で実行する。
  ```bash
  docker compose exec app <command>
  # 例: docker compose exec app php artisan migrate
  ```
- **Docker Compose のプロジェクト名は `docker-compose.yml` の `name:` で管理する**(コミット済み・チーム共有)。
- **`.env` の扱いに注意**。
  - ルート直下 `.env` … Docker Compose 用のローカル上書き専用。**git 管理外**(`.gitignore` で除外)。共有すべき設定は `docker-compose.yml` に持たせる。
  - `htdocs/.env` … Laravel アプリケーション用(DB・メール・ログ設定など)。

## Git / GitHub 運用ルール

### コミットメッセージ
- **日本語**で記述する。
- 1行目は変更内容を簡潔に要約する(例: `DBクエリを記録する`、`ログを日毎に別ファイルへ記録する`)。
- prefix(`feat:` `fix:` など)は付けない。これまでの履歴に合わせる。
- 1コミット1目的を心がけ、無関係な変更を混ぜない。

### ブランチ
- `main` が本流。作業は `main` から直接コミットせず、ブランチを切る。
- ブランチ名は `feature/...`、`fix/...` のように用途を表す。

### プルリクエスト
- PR の作成・更新には `gh` CLI を使う(認証済み)。
- PR タイトル・説明は日本語で記述する。
- 説明には「何を・なぜ」変更したかを簡潔にまとめる。

### 操作の確認
- commit / push / PR 作成など、リポジトリやリモートを変更する操作は実行前に確認する。
- 読み取り系の git / gh コマンド(status, diff, log, pr view など)は確認なしで実行してよい。

## 開発環境
- PHP / Composer / npm が利用可能。
- Laravel Boost(MCP)が有効。DB スキーマ参照やドキュメント検索に活用する。

## コーディング規約

### フロントエンド(Vue + Inertia)
- **Vue 3 + TypeScript** を使用。新規コードも型を付ける(ビルド時に `vue-tsc` が型チェックする)。
- 画面コンポーネントは `resources/js/Pages`、共通 UI は `Components`、レイアウトは `Layouts` に置く。
- 認証まわりは **Laravel Breeze**(Vue + TS)のスキャフォールド。既存の Components / Layouts を再利用する。
- JS からのルート参照は **Ziggy の `route()`** ヘルパを使う(URL のハードコードを避ける)。

### コードスタイル / 品質チェック
- PHP は **Laravel Pint** で整形する。
  ```bash
  docker compose exec app ./vendor/bin/pint
  ```
- フロントエンドは `npm run build` 時に `vue-tsc` で型チェックされる。
- テストは **PHPUnit**(`htdocs/tests`、SQLite in-memory)。
  ```bash
  docker compose exec app php artisan test
  ```
