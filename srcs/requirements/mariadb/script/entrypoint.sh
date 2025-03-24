#!bin/bash

set -e

if [! -d "/var/lib/mysql/mysql"]; then
	echo "MariaDb initialisation..."
	mysqld --initialize-insecure
	if [! -f /docker-entrypoint-initdb.d/init.sql]; then
		echo "Executing initialization script..."
		envsubst < /docker-entrypoint-initdb.d/init.sql > /tmp/init.sql
		mysqld --skip-networking &
		pid="$!"
		sleep 5
		mysql < /tmp/init.sql
		kill "$pid"
	fi
fi
echo "Starting  mysql..."
exec mysqld