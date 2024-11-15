FROM	debian:bullseye

RUN	apt-get update -y && \
	apt-get install -y curl php php-fpm php-mysql

RUN	php-fpm7.4 --version

RUN	sed -i 's|^listen = /run/php/php7.4-fpm.sock|listen = 0.0.0.0:7000|' /etc/php/7.4/fpm/pool.d/www.conf

RUN	mkdir -p /var/www/html/adminer && \
	chmod -R 777 /var/www/html/adminer && \
	chown -R www-data:www-data /var/www/html/adminer

RUN	mkdir -p /run/php

COPY	/tools/start.sh /usr/local/bin/start.sh

RUN	chmod +x /usr/local/bin/start.sh

WORKDIR	/var/www/html/adminer

EXPOSE 7000

ENTRYPOINT	["/usr/local/bin/start.sh"]
CMD	["/usr/sbin/php-fpm7.4", "-F"]
