#!/bin/bash

#Make sure MariaDB has started properly
sleep 10

if [ -f "/var/www/wordpress/wp-config.php" ]; then
	echo "wp-config file already set up."
else
	wp core download --allow-root

	wp core config \
	       	--dbname=$SQL_DATABASE \
		--dbuser="${SQL_USER}" \
		--dbpass="${SQL_PASSWORD}" \
		--dbhost=mariadb:3306 \
		--path='/var/www/wordpress'

	wp core install \
		--url="${WP_URL}" \
		--title="${WP_TITLE}" \
		--admin_user="${WP_ADMIN_USER}" \
		--admin_passsword="${WP_ADMIN_PASSWORD}" \
		--admin_email="${WP_ADMIN_EMAIL}" \
		--allow-root

	wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
		--role=author \
		--user_pass="$(cat /run/secrets/wp_password)" \
		--allow-root
fi

exec php-fpm7.4 -F -R
