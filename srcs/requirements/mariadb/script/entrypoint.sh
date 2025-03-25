#!/bin/bash
set -e

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "====> MariaDB initialization..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql --skip-test-db
    # Ensuite, si init.sql existe, on l'exécute.
    if [ -f /docker-entrypoint-initdb.d/init.sql ]; then
        echo "====> Running custom init.sql..."
        # On lance mariadbd en background sans contrainte de password
        mariadbd --skip-networking --user=mysql &
        pid="$!"
        sleep 30
        # On exécute le script SQL
        mysql --user=root --password=rootpassword < /docker-entrypoint-initdb.d/init.sql
        kill "$pid"
    fi
fi

echo "====> Starting mariadb..."
exec mariadbd --user=mysql
