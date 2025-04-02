FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    curl \
    wget \
    mariadb-client \
    ghostscript \
    php8.2 \
    php8.2-fpm \
    php8.2-mysql \
    php8.2-bcmath \
    php8.2-curl \
    php8.2-imagick \
    php8.2-intl \
    php8.2-mbstring \
    php8.2-xml \
    php8.2-zip \
	nano \
    && apt-get clean

RUN ln -s "$(which php-fpm8.2)" /usr/sbin/php-fpm || true

WORKDIR /var/www/html

RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz \
 && tar -xzf wordpress-6.0-fr_FR.tar.gz --strip-components=1 \
 && rm wordpress-6.0-fr_FR.tar.gz

RUN chown -R root:root /var/www/html

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

COPY conf/php.conf /etc/php/8.2/fpm/pool.d/www.conf

COPY ./script/auto_config.sh /usr/local/bin/auto_config.sh
RUN chmod +x /usr/local/bin/auto_config.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/auto_config.sh"]