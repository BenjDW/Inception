FROM debian:bookworm

RUN apt update && apt install -y apache2 \
ghostscript \
libapache2-mod-php \
php \
php-bcmath \
php-curl \
php-imagick \
php-intl \
php-json \
php-mbstring \
php-mysql \
php-xml \
php-zip \
php-fpm \
curl

RUN mkdir -p /srv/www && chown www-data: /srv/www 
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp
