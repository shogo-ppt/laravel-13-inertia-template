FROM php:8.3-cli

# PHP拡張に必要なパッケージ + Node.js 22 のセットアップ
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libxml2-dev \
    libzip-dev \
    unzip \
    && docker-php-ext-install pdo pdo_mysql xml dom zip \
    && curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# ホストと同じ UID/GID(1000) のユーザーを作成し、生成ファイルをホストで編集可能にする。
# Linux / WSL2 ではバインドマウントの所有者(UID)がそのまま貫通するため、
# コンテナを root で動かすと生成ファイルが root 所有になりホストで編集できなくなる。
# ※ Mac(Docker Desktop) ではファイル共有層が所有者をホストユーザーに自動マッピングするため、
#   この対策（useradd / USER www）は不要。Linux / WSL2 環境のために入れている。
RUN useradd -u 1000 -m -s /bin/bash www \
    && mkdir -p /var/www/html \
    && chown -R www:www /var/www

WORKDIR /var/www/html

EXPOSE 8000

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 実行ユーザーを root から www(UID 1000) に切り替え（Mac では不要・上記コメント参照）
USER www

ENTRYPOINT ["/entrypoint.sh"]
