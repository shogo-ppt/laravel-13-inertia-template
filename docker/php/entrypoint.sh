#!/bin/sh
set -e

# PHP依存パッケージ
composer install --no-interaction

# フロントエンド依存 + ビルド
npm install
npm run build

# Laravel初期化
php artisan key:generate --force
php artisan migrate --force

# サーバ起動
php artisan serve --host=0.0.0.0 --port=8000
