#!/bin/bash
set -e

# Créer les répertoires nécessaires et régler les permissions
mkdir -p /run/mysqld /var/lib/mysql
chown -R mysql:mysql /run/mysqld /var/lib/mysql

# Si la base n'a pas encore été initialisée, la créer
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "====> MariaDB initialization..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql --skip-test-db
    # Ensuite, si init.sql existe, on l'exécute.
    if [ -f /docker-entrypoint-initdb.d/init.sql ]; then
        echo "====> Running custom init.sql..."
        # On lance mariadbd en background sans contrainte de password
        mariadbd --skip-networking --user=mysql &
        pid="$!"
        sleep 5
        # On exécute le script SQL
        mysql -u root < /docker-entrypoint-initdb.d/init.sql
        kill "$pid"
    fi
fi

echo "====> Starting mariadb..."
exec mariadbd --user=mysql
