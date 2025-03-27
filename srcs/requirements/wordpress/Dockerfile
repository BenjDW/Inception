FROM debian:bookworm

#apt upgrade // install les update
RUN apt update && apt upgrade && apt install -y apache2 \
ghostscript \
libapache2-mod-php \
php \
php-bcmath \
php-curl \
php-imagick \
php-intl \
php-json \
php-mbstring \
php-mysql \
php-xml \
php-zip \
php-fpm \
mariadb-client \
iputils-ping \
curl \
apt-get -y install wget

RUN mkdir -p /srv/www && chown www-data: /srv/www 
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

RUN echo "ServerName localhost" | tee /etc/apache2/conf-available/fqdn.conf && \
a2enconf fqdn

RUN wp core download --path=/srv/www --allow-root

COPY ./script/credentials_env.sh usr/local/bin/credentials_env.sh
RUN chmod +x /usr/local/bin/credentials_env.sh

ENTRYPOINT ["/usr/local/bin/credentials_env.sh"]
EXPOSE 3306

# sets the apache2ctl in foreground to not finish the docker
CMD ["apache2ctl", "-D", "FOREGROUND"]