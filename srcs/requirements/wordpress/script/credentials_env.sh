#!/bin/bash

set -e

if [ ! -f /srv/www/wp-config.php ]; then
  echo "wp-config.php not set, creating..."
  cp /srv/www/wp-config-sample.php /srv/www/wp-config.php

  sed -i "s/database_name_here/${MYSQL_DATABASE}/g" /srv/www/wp-config.php
  sed -i "s/username_here/${MYSQL_USER}/g" /srv/www/wp-config.php
  sed -i "s/password_here/${MYSQL_PASSWORD}/g" /srv/www/wp-config.php
  sed -i "s/localhost/mariadb/g" /srv/www/wp-config.php
fi

echo "wp-config created..."
exec apache2ctl -D FOREGROUND
