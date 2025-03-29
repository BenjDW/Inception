FROM debian:bookworm

# 1) Installer les paquets requis : PHP 8.2, mariadb-client, etc.
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
    && apt-get clean

# 2) Créer un symlink "php-fpm" -> "php-fpm8.2" pour simplifier le lancement
RUN ln -s "$(which php-fpm8.2)" /usr/sbin/php-fpm || true

# 3) Définir le répertoire de travail sur /var/www/html
#    (C'est là qu'on va installer WordPress, au lieu de /var/www/wordpress)
WORKDIR /var/www/html

# 4) Télécharger WordPress en français et l'extraire directement dans /var/www/html
RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz \
 && tar -xzf wordpress-6.0-fr_FR.tar.gz --strip-components=1 \
 && rm wordpress-6.0-fr_FR.tar.gz

# 5) Ajuster les droits
RUN chown -R root:root /var/www/html

# 6) Installer WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# 7) Copier la config PHP-FPM (pool www)
#    Note : sous Debian bookworm, la config se trouve dans /etc/php/8.2/fpm/pool.d/
COPY conf/php.conf /etc/php/8.2/fpm/pool.d/www.conf

# 8) Copier le script d'auto-configuration
COPY ./script/auto_config.sh /usr/local/bin/auto_config.sh
RUN chmod +x /usr/local/bin/auto_config.sh

# 9) Exposer le port 9000 (PHP-FPM écoute en interne)
EXPOSE 9000

# 10) Lancer le script auto_config.sh (qui démarre ensuite php-fpm)
ENTRYPOINT ["/usr/local/bin/auto_config.sh"]
