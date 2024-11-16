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


	echo "Installing Redis Cache plugin..."
	wp plugin install redis-cache --activate --allow-root || { echo "Failed to install redis-cache plugin"; exit 1; }
	echo "Setting up redis-cache..."
	wp config set WP_CACHE true --raw --allow-root|| { echo "Redis-cache CACHE config setup failed"; exit 1; }
	wp config set WP_REDIS_HOST 'redis' --allow-root || { echo "Redis-cache HOST config setup failed"; exit 1; }
	wp config set WP_DEBUG true --raw --allow-root || { echo "Redis-cache WP_DEBUG config setup failed"; exit 1; }
	wp config set WP_REDIS_PORT 6379 --raw --allow-root || { echo "Redis-cache PORT config setup failed"; exit 1; }

	echo "Installing elasticpress plugin..."
	wp plugin install elasticpress --activate --allow-root --path=/var/www/html || { echo "Failed to install elasticpress plugin"; exit 1; }
	#wp config set EP_HOST elasticsearch:9200 --raw --allow-root --path=/var/www/html || { echo "Failed to set elasticsearch EP_HOST"; exit 1; } 

	echo "Installing php-redis extension"
	apt-get install -y php-redis || { echo "Failed to install redis php extension"; exit 1; }
	#service php7.4-fpm restart || { echo "Failed to restart php7.4-fpm"; exit 1; }
	wp plugin activate redis-cache --allow-root
	wp redis enable --allow-root || { echo "Could not enable object caching"; exit 1; }
	echo "Creating user..."
	wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
		--role=subscriber \
		--user_pass="$(cat /run/secrets/wp_password)" \
		--allow-root|| { echo "Wordpress user create failed"; exit 1; }
fi

exec php-fpm7.4 -F -R
