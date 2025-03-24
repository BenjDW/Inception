#!bin/bash

set -e

if [! -d "/var/lib/mysql/mysql"]; then
	echo "MariaDb initialisation..."
	mysqld --initialize-insecure
	if [! -f /docker-entrypoint-initdb.d/init.sql]; then # if this file does not exist
		echo "Executing initialization script..."
		envsubst < /docker-entrypoint-initdb.d/init.sql > /tmp/init.sql # replace initial env with init.sql
		mysqld --skip-networking &	# execute init command in bg w/o password by default - create files and folders
		pid="$!"					# get the mariadb pid running in background set above
		sleep 5
		mysql < /tmp/init.sql		# execute init.sql commands and sets everything in the db
		kill "$pid"					# kill the previous processus when init done
	fi
fi
echo "Starting  mysql..."
exec mysqld