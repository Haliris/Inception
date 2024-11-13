FROM	debian:bullseye

RUN	apt-get update && apt-get upgrade -y
RUN	apt-get install -y net-tools
RUN	apt-get -y install wget
RUN	apt-get install -y php7.4\
	php-fpm\
	php-mysql\
	mariadb-client

RUN	sed -i 's|^listen = /run/php/php7.4-fpm.sock|listen = 0.0.0.0:9000|' /etc/php/7.4/fpm/pool.d/www.conf

RUN	mkdir -p /var/www/html && \
	chmod -R 777 /var/www/html

RUN	wget https://ft.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www/html
RUN	cd /var/www/html && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz
RUN	chown -R root:root /var/www/html

RUN	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN	chmod +x wp-cli.phar
RUN	mv wp-cli.phar /usr/local/bin/wp
RUN	wp --info

RUN	chown -R www-data:www-data /var/www/html

WORKDIR	/var/www/html

COPY	./tools/auto_config.sh /usr/local/bin/auto_config.sh
RUN	chmod +x /usr/local/bin/auto_config.sh && mkdir -p /run/php

EXPOSE	9000

CMD	exec /usr/local/bin/auto_config.sh
