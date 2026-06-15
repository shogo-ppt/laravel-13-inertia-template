# Laravel 13 + Inertia.js テンプレート

Laravel 13 と Inertia.js / Vue 3 を組み合わせた SPA 開発用のテンプレートです。
Docker Compose で開発環境一式（アプリ・MySQL・phpMyAdmin・Mailpit）が起動します。

## 技術スタック

### バックエンド
- **PHP** 8.3
- **Laravel** 13
- **Inertia.js (Laravel アダプタ)** 2.0
- **Laravel Sanctum** 4.0 — 認証
- **Laravel Breeze** — 認証スキャフォールド（Vue + TypeScript）
- **Ziggy** — ルートを JS から参照
- **Laravel Boost** — AI 開発支援（MCP）

### フロントエンド
- **Vue** 3
- **TypeScript**
- **Inertia.js (Vue 3 アダプタ)** 2.0
- **Tailwind CSS** 3
- **Vite** 8

### 開発環境（Docker）
- **app** — PHP 8.3 + Node.js 22（`php artisan serve`）: http://localhost:8000
- **db** — MySQL 8.0: `localhost:3306`
- **phpmyadmin** — DB 管理 UI: http://localhost:8080
- **mailpit** — メール検証 UI: http://localhost:8025（SMTP: 1025）

## セットアップ

前提: Docker / Docker Compose が利用できること。

```bash
# 1. アプリ用の .env を用意
cp htdocs/.env.example htdocs/.env
```

次に、ルート直下の `.env` でプロジェクト名を指定します。
`COMPOSE_PROJECT_NAME` がコンテナ名・ネットワーク名・ボリューム名の接頭辞になります。
複数プロジェクトを同時に動かす際の名前衝突を避けるため、テンプレートを利用する際は
プロジェクトに合わせた値へ変更してください。

```dotenv
# .env（ルート直下 / Docker Compose 用）
COMPOSE_PROJECT_NAME=your-project-name
```

```bash
# 2. コンテナをビルドして起動
docker compose up -d --build
```

初回起動時、`app` コンテナの entrypoint が以下を自動実行します。

- `composer install`
- `npm install` & `npm run build`
- `php artisan key:generate`
- `php artisan migrate`

起動後、http://localhost:8000 にアクセスできます。

> ルート直下の `.env`（`COMPOSE_PROJECT_NAME`）は Docker Compose 用、
> `htdocs/.env` は Laravel アプリケーション用です。役割が異なる点に注意してください。

## よく使うコマンド

コンテナ内で artisan / npm / composer を実行します。

```bash
# コンテナのシェルに入る
docker compose exec app bash

# artisan
docker compose exec app php artisan migrate
docker compose exec app php artisan tinker

# フロントエンド（開発時のホットリロード）
docker compose exec app npm run dev

# テスト
docker compose exec app php artisan test

# コードスタイル（Laravel Pint）
docker compose exec app ./vendor/bin/pint
```

## ディレクトリ構成

```
.
├── docker/                # Docker 関連（PHP イメージ・entrypoint）
├── docker-compose.yml     # 開発環境の定義
├── .env                   # Docker Compose 用（プロジェクト名など）
└── htdocs/                # Laravel アプリケーション本体
    ├── app/
    ├── routes/            # web.php / auth.php / console.php
    ├── resources/js/      # Vue + Inertia（Pages / Components / Layouts）
    └── ...
```

## Laravel Boost（AI 開発支援）

本テンプレートには Laravel Boost（MCP サーバ）が組み込まれています。
`.mcp.json` に定義済みで、`app` コンテナ経由で起動します。DB スキーマ参照や
ドキュメント検索などを AI コーディングエージェントから利用できます。

## 開発ルール

コミットメッセージやブランチ・PR の運用ルールは [`CLAUDE.md`](./CLAUDE.md) を参照してください。
