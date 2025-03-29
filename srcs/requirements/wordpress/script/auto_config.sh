#!/bin/bash

# Attendre que la DB soit prête
until mysqladmin ping -h"mariadb" --silent; do
    echo "Waiting for MariaDB..."
    sleep 2
done

cd /var/www/wordpress

if [ -f wp-config.php ]; then
    echo "WordPress is already set up."
else
    echo "No wp-config.php found. Setting up WordPress..."

    wp config create --allow-root \
        --dbname="${SQL_DATABASE}" \
        --dbuser="${SQL_USER}" \
        --dbpass="${SQL_PASSWORD}" \
        --dbhost="mariadb:3306" \
        --path="/var/www/wordpress"

    if ! wp core is-installed --allow-root; then
        wp core install --allow-root \
            --url="localhost" \
            --title="Blog Title" \
            --admin_user="master" \
            --admin_password="password" \
            --admin_email="email@domain.com" \
            --path="/var/www/wordpress"
    fi
fi

# Lancer PHP-FPM par le symlink
echo "Starting php-fpm..."
exec php-fpm -F
