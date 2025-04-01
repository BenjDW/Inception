#!/bin/bash

# Attendre que la DB soit prête
until mysqladmin ping -h"mariadb" --silent; do
    echo "Waiting for MariaDB..."
    sleep 2
done

cd /var/www/html

if [ -f wp-config.php ]; then
    echo "WordPress is already set up."
else
    echo "No wp-config.php found. Setting up WordPress..."

    wp config create --allow-root \
        --dbname="${SQL_DATABASE}" \
        --dbuser="${SQL_USER}" \
        --dbpass="${SQL_PASSWORD}" \
        --dbhost="mariadb:3306" \
        --path="$WP_PATH"
    if ! grep -q "define('WP_HOME'" "/var/www/html/wp-config.php"; then
        echo "Ajout des constantes WP_HOME et WP_SITEURL au début de wp-config.php..."
        # Insérer les définitions WP_HOME et WP_SITEURL après "<?php"
        sed -i "1a\define('WP_HOME', 'https://bde-wits.42.fr');\ndefine('WP_SITEURL', 'https://bde-wits.42.fr');\n" "/var/www/html/wp-config.php"
    else
        echo "Les constantes WP_HOME et WP_SITEURL sont déjà définies."
    fi

    # if ! wp core is-installed --allow-root; then
        wp core install --allow-root \
            --url="$WP_DOMAIN" \
            --title="$Wp_TITLE" \
            --admin_user="$WP_ADMIN_USER" \
            --admin_password="$WP_ADMIN_MDP" \
            --admin_email="$WP_ADMIN_MAIL" \
            --path="$WP_PATH"
# cree le second user a test
		wp user create "$WP_BASIC_USER" "$WP_USER_MAIL" --role=editor --user_pass="$WP_USER_MDP" --allow-root --path="$WP_PATH"
    # fi
fi

# Lancer PHP-FPM par le symlink
echo "Starting php-fpm..."
exec php-fpm -F
