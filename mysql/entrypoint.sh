#!/bin/sh

set -x

echo "Starting the mysql daemon"
service mariadb start

#/usr/bin/mysqld_safe --defaults-file=/etc/mysql/my.cnf --datadir=/var/lib/mysql --pid-file=/var/run/mysqld/mysqld.pid --log-error=/var/log/mysql/error.log --user=mysql

sleep 10

mysql -e "CREATE USER 'nextcloud'@'%' IDENTIFIED BY 'passw@rd';"

mysql -e "CREATE DATABASE IF NOT EXISTS nextcloud CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci; GRANT ALL PRIVILEGES ON nextcloud.* TO 'nextcloud'@'%';FLUSH PRIVILEGES;"