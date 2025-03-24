FROM debian:bookworm

RUN apt update && apt install -y mariadb-server
	# mysql_secure_installation
	# echo '\n'
	# echo 'n'
	# echo 'n'
	# sudo mariadb
	# CREATE USER 'root'@'localhost' IDENTIFIED BY '';
	# GRANT ALL ON *.* TO 'rootuser'@'8080' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;
	# FLUSH PRIVILEGES;
	# exit
#script
RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld

#COPY conf/mysqld.conf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY init.sql /docker-entrypoint-initdb.d/

VOLUME "/var/lib/mysql"

EXPOSE 3306 

# exec le script
CMD ["mysqld"]