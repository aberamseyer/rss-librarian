FROM composer:2 AS vendor
WORKDIR /app
COPY composer.json composer.lock ./
RUN composer install --no-dev --no-interaction --prefer-dist --ignore-platform-reqs

FROM php:8.3-apache
RUN cp "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
COPY docker/vhost.conf /etc/apache2/sites-available/000-default.conf
COPY --from=vendor /app/vendor /var/www/html/vendor
COPY librarian.php /var/www/html/
