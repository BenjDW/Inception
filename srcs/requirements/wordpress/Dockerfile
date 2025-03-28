FROM debian:bookworm

#apt upgrade // install les update
RUN apt update && apt upgrade -y \
ghostscript \
#libapache2-mod-php \
php \
php-fpm \
php-mysql \
mariadb-client \
php-bcmath \
php-curl \
php-imagick \
php-intl \
php-json \
php-mbstring \
php-xml \
php-zip \
iputils-ping \
curl 

RUN apt-get install wget -y
RUN apt-get install php7.3 -y



RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz
RUN	chown -R root:root /var/www/wordpress
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY conf/php.conf /etc/php/7.3/fpm/pool.d/www.conf
COPY ./script/auto_config.sh /usr/local/bin/auto_config.sh
RUN chmod 777 /usr/local/bin/auto_config.sh

EXPOSE 3306
#port 3306 mariadb-wordpress
EXPOSE 9000
#port 9000 nginx-wordpress
ENTRYPOINT ["/usr/local/bin/auto_config.sh"]
CMD ["/usr/sbin/php-fpm7.3" "-F"]
# CMD ["php-fpm7.3", "-F"]

# RUN mkdir -p /srv/www && chown www-data: /srv/www 
# RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
#     && chmod +x wp-cli.phar \
#     && mv wp-cli.phar /usr/local/bin/wp

# RUN echo "ServerName localhost" | tee /etc/apache2/conf-available/fqdn.conf && \
# a2enconf fqdn

# RUN wp core download --path=/srv/www --allow-root
# COPY ./script/credentials_env.sh usr/local/bin/credentials_env.sh
# RUN chmod +x /usr/local/bin/credentials_env.sh

# ENTRYPOINT ["/usr/local/bin/credentials_env.sh"]
# sets the apache2ctl in foreground to not finish the docker
# CMD ["apache2ctl", "-D", "FOREGROUND"]