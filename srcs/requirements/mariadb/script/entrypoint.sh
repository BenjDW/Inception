#!/bin/bash
set -e

    echo "====> MariaDB initialization..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql --skip-test-db
    if [ -f /docker-entrypoint-initdb.d/init.sql ]; then
        echo "====> Running custom init.sql..."
		envsubst < /tmp/init.sql > /docker-entrypoint-initdb.d/init.sql
        mariadbd --skip-networking --user=mysql &
        pid="$!"
        sleep 5
        mysql --user=root --password=rootpassword < /docker-entrypoint-initdb.d/init.sql
        kill "$pid"
    fi

echo "====> Starting mariadb..."
exec mariadbd --user=mysql