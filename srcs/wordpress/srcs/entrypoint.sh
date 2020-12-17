#!/bin/sh

# terminate on errors
set -e

PHP_CGI_FIX_PATHINFO=0
# DATABASE_NAME=wordpress
# USERNAME=username
# PASSWORD=password
# WORDPRESS_DB_HOST=wordpress-mysql

# Configure PHP
sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo=$PHP_CGI_FIX_PATHINFO|i" /etc/php7/php.ini

# Configure wp-config
sed -i "s/database_name_here/$DATABASE_NAME/" /usr/src/wordpress/wp-config.php
sed -i "s/username_here/$USERNAME/" /usr/src/wordpress/wp-config.php
sed -i "s/password_here/$PASSWORD/" /usr/src/wordpress/wp-config.php
sed -i "s/localhost/$WORDPRESS_DB_HOST/" /usr/src/wordpress/wp-config.php
sed -i "s/utf8/utf8mb4/" /usr/src/wordpress/wp-config.php

# Generate secret-keys
curl -fs https://api.wordpress.org/secret-key/1.1/salt/ >> /usr/src/wordpress/wp-secret-keys.php

# Check if volume is empty
if [ ! "$(ls -A "/var/www/wp-content" > /dev/null 2>&1)" ]; then
    # Copy wp-content from Wordpress src to volume
    cp -r /usr/src/wordpress/wp-content /var/www/
    chown -R nobody:nobody /var/www
fi

cat > /tmp/sql << EOF
CREATE DATABASE IF NOT EXISTS $DATABASE_NAME;
CREATE USER '$USERNAME'@'172-17-0-%.$DATABASE_NAME.default.svc.cluster.local' IDENTIFIED BY '$PASSWORD';
GRANT ALL PRIVILEGES ON $DATABASE_NAME.* TO '$USERNAME'@'172-17-0-%.$DATABASE_NAME.default.svc.cluster.local' WITH GRANT OPTION;
EOF

# Wait until mysql is up
# until sudo -u nobody wp db check --path="/usr/src/wordpress"; do
# 	echo waiting for mysql;
# 	sleep 2;
# done
until mysql --host=$WORDPRESS_DB_HOST --user=root --password=$MYSQL_ROOT_PASSWORD < /tmp/sql; do
	echo waiting for mysql;
	sleep 3;
done

# mysql --host=$WORDPRESS_DB_HOST --user=root --password=$MYSQL_ROOT_PASSWORD < /tmp/sql
# rm /tmp/sql

# adduser --no-create-home -D $USERNAME
# echo "$USERNAME:$PASSWORD" | chpasswd
# chmod -R 755 /usr/src/
# chown -R $USERNAME:$USERNAME /usr/src/wordpress

/usr/sbin/php-fpm7
nginx -g "daemon off;"

exec "$@"
