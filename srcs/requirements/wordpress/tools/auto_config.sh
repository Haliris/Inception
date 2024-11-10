#!bin/bash

#Make sure MariaDB has started properly
sleep 10

if [ ! -d "/var/www/html/wordpress/wp-config.php" ]; then
	wp config create --allow-root \
		--dbname=$SQL_DATABASE \
		--dbuser=$SQL_USER \
		--dbpass=$SQL_PASSWORD \
		--dbhost=mariadb:3306 --path='/var/www/html/wordpress'
fi
