FROM debian:bookworm

RUN apt update && apt upgrade && apt install -y mariadb-server

#script
# RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld
RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld \
    && chown -R mysql:mysql /var/lib/mysql

COPY init.sql /docker-entrypoint-initdb.d/init.sql
COPY ./script/entrypoint.sh /usr/local/bin/entrypoint.sh
COPY ./conf/mysqld.conf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["mysqld"]