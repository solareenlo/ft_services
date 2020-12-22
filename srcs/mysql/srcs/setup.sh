#!/bin/sh

# MYSQL_ROOT_PASSWORD=password

mysql_install_db --user=root --ldata=/var/lib/mysql

cat > /tmp/sql << EOF
USE mysql;
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'172.17.0.%' IDENTIFIED BY "$MYSQL_ROOT_PASSWORD" WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
ALTER USER 'root'@'localhost' IDENTIFIED BY '';
DROP DATABASE IF EXISTS test;
EOF

/usr/bin/mysqld --user=root --bootstrap < /tmp/create_tables.sql
/usr/bin/mysqld --user=root --bootstrap < /tmp/sql
rm -f /tmp/create_tables.sql /tmp/sql

exec /usr/bin/mysqld --user=root
