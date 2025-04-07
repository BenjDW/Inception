FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    curl \
    wget \
    mariadb-client \
    ghostscript \
    php7.4 \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-bcmath \
    php7.4-curl \
    php7.4-imagick \
    php7.4-intl \
    php7.4-mbstring \
    php7.4-xml \
    php7.4-zip \
	nano \
    && apt-get clean

RUN ln -s "$(which php-fpm7.4)" /usr/sbin/php-fpm || true

WORKDIR /var/www/html

RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz \
 && tar -xzf wordpress-6.0-fr_FR.tar.gz --strip-components=1 \
 && rm wordpress-6.0-fr_FR.tar.gz

RUN chown -R root:root /var/www/html

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

COPY conf/php.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY ./script/auto_config.sh /usr/local/bin/auto_config.sh
RUN mkdir -p /run/php
RUN chmod +x /usr/local/bin/auto_config.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/auto_config.sh"]