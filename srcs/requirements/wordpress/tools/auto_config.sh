#!/bin/bash

#Make sure MariaDB has started properly
sleep 10

if [ -f "/var/www/html/wp-config.php" ]; then
	echo "wp-config file already set up."
else
	if [ ! -d "/var/www/html/wp-content" ]; then
		wp core download --allow-root || { echo "Wordpress download failed"; exit 1; }
	else
		echo "WordPress files already present, skipping download."
	fi
	echo "Setting up wp-config.php..."
	wp core config --allow-root \
	       	--dbname=$SQL_DATABASE \
		--dbuser="${SQL_USER}" \
		--dbpass="${SQL_PASSWORD}" \
		--dbhost=mariadb:3306 \
		--path='/var/www/html' || { echo "Wordpress core config failed"; exit 1; }

	echo "Installing WordPress..."
	wp core install \
		--url="${WP_URL}" \
		--title="${WP_TITLE}" \
		--admin_user="${WP_ADMIN_USER}" \
		--admin_password="${WP_ADMIN_PASSWORD}" \
		--admin_email="${WP_ADMIN_EMAIL}" \
		--allow-root || { echo "Wordpress core install failed"; exit 1; }

	echo "Creating user..."
	wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
		--role=subscriber \
		--user_pass="$(cat /run/secrets/wp_password)" \
		--allow-root|| { echo "Wordpress user create failed"; exit 1; }
fi

exec php-fpm7.4 -F -R
