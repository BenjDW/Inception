FROM debian:bookworm

RUN apt update && apt install -y mariadb-server

#script
RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld

#COPY conf/mysqld.conf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY init.sql /docker-entrypoint-initdb.d/
COPY ./script/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
USER mysql

VOLUME ["/var/lib/mysql"]

EXPOSE 3306


ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["mysqld"]