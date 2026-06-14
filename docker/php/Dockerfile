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

WORKDIR /var/www/html

EXPOSE 8000

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
