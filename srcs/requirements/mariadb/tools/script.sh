#!/bin/bash
set -euo pipefail

if [ -z "${SQL_DATABASE:-}" ] || [ -z "${SQL_USER:-}" ]; then
  echo "Required environment variables SQL_DATABASE or SQL_USER are not set."
  exit 1
fi

service mariadb start
sleep 3

mysql -e "CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};"
mysql -e "CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '$(cat /run/secrets/db_password)';"
mysql -e "GRANT ALL PRIVILEGES ON ${SQL_DATABASE}.* TO '${SQL_USER}'@'%';"
mysql -e "FLUSH PRIVILEGES;"

mysqladmin -u root shutdown
exec mysqld
