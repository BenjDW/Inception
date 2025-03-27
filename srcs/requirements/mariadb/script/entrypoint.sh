#!/bin/bash
set -e

# sleep 20
# if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "====> MariaDB initialization..."
	# mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld \
    # && chown -R mysql:mysql /var/lib/mysql
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql --skip-test-db
    # Ensuite, si init.sql existe, on l'exécute.
    if [ -f /docker-entrypoint-initdb.d/init.sql ]; then
        echo "====> Running custom init.sql..."
        # On lance mariadbd en background sans contrainte de password
        mariadbd --skip-networking --user=mysql &
        pid="$!"
        sleep 5
        # On exécute le script SQL
        mysql --user=root --password=rootpassword < /docker-entrypoint-initdb.d/init.sql
        kill "$pid"
    fi
# fi

echo "====> Starting mariadb..."
exec mariadbd --user=mysql
