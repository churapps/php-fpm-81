FROM php:8.1.2-fpm-alpine3.15

# php ext
RUN apk update && \
    apk --no-cache upgrade && \
    apk --no-cache add libmcrypt-dev mysql-client git openssl-dev oniguruma-dev

# php ext redis
RUN docker-php-source extract && \
    git clone -b release/5.3.6 --depth 1 https://github.com/phpredis/phpredis.git /usr/src/php/ext/redis && \
    docker-php-ext-install redis && \
    docker-php-source delete

RUN docker-php-ext-install pdo_mysql mbstring

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN composer config -g repos.packagist composer https://packagist.jp
#RUN composer global require hirak/prestissimo

## detail config
# COPY ./config/www.conf /usr/local/etc/php-fpm.d/www.conf
