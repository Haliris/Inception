#!/bin/bash

# Wait for MySQL to start properly
until mysqladmin ping --silent; do
    echo "Waiting for MySQL to be available..."
    sleep 1
done

# Create database if not exists
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

# Create user and set password if not exists
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

# Grant privileges to the user
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';"

# Set root password
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

# Flush privileges to ensure changes are applied
mysql -e "FLUSH PRIVILEGES;"

# Keep the container running by exec'ing the MariaDB server
exec mysqld_safe

