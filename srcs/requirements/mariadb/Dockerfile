FROM debian:bookworm

RUN sudo apt install mariadb-server
	sudo mysql_secure_installation
	echo '\n'
	echo 'n'
	echo 'n'
	sudo mariadb
	GRANT ALL ON *.* TO 'rootuser'@'8080' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;
	FLUSH PRIVILEGES;
	exit
VOLUME "/var/lib/mysql"

CREATE USER 'root'@'localhost' IDENTIFIED BY 'mdp';

//port
EXPOSE 3306 