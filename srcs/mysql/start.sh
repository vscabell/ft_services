#!/bin/sh

if [ ! -d "/run/mysqld" ]; then
  mkdir -p /run/mysqld
fi

cd '/usr' ; /usr/bin/mysqld_safe --datadir='/var/lib/mysql'
cd /

cat << EOF > config.sql
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
EOF

chmod +w config.sql

mysql_install_db --user=root --basedir=/usr --datadir=/var/lib/mysql

mysqld --user=root --skip_networking=0 --init-file=/config.sql