#!/bin/bash

set -eo pipefail

if [ ! -d "/var/lib/mysql/is_init" ]; then
	mysql_install_db --user=mysql --datadir=/var/lib/mysql
	mysqld --user=mysql --skip-networking &
	pid="$!"

	until mysqladmin ping -h"localhost" --silent; do
		echo "Waiting for MariaDB to be ready.."
		sleep 3
	done

	mysql -e "CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};"
	mysql -e "CREATE USER IF NOT EXISTS `${SQL_USER}`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
	mysql -e "GRANT ALL PRIVILEGES ON '${SQL_DATABASE}`.* TO \`${SQL_USER}`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
	mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
	mysql -e "FLUSH PRIVILEGES;"

	echo "done" > /var/lib/mysql/is_init
	mysqladmin -u root -p $SQL_ROOT_PASSWORD shutdown
	wait "$pid"
fi

exec gosu mysql "$@"
