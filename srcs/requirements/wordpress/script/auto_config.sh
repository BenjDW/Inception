#!/bin/bash

sleep 10

wp config create --allow-root \
	--dbname=$SQL_DATABASE \
	--dbuser=$SQL_USER \
	--dbpass=$SQL_PASSWORD \
	--dbhost=mariadb:3306 --path='/var/www/wordpress'

wp core install --allow-root --url='https://bde-wits42.fr' --title='Blog Title' --admin_user='master' --admin_password='password' --admin_email='email@domain.com'

# wp user create