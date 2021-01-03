#!/bin/sh

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
CREATE USER '$USERNAME'@'172.17.0.%' IDENTIFIED BY '$PASSWORD';
GRANT ALL PRIVILEGES ON $DATABASE_NAME.* TO '$USERNAME'@'172.17.0.%' WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON phpmyadmin.* TO '$USERNAME'@'172.17.0.%' IDENTIFIED BY '$PASSWORD' ;
EOF

mysql --host=$WORDPRESS_DB_HOST --user=root --password=$MYSQL_ROOT_PASSWORD < /tmp/sql
rm /tmp/sql

if ! $(wp user list --role=administrator --path=/usr/src/wordpress); then
	wp core install \
		--url=${WP_URL} \
		--title=Example \
		--admin_user=admin \
		--admin_password=password \
		--admin_email=info@example.com \
		--skip-email \
		--path=/usr/src/wordpress
	wp user create \
		editor editor@example.com \
		--user_pass=password \
		--role=editor \
		--path=/usr/src/wordpress
	wp user create \
		author author@example.com \
		--user_pass=password \
		--role=author \
		--path=/usr/src/wordpress
	wp user create \
		contributor contributor@example.com \
		--user_pass=password \
		--role=contributor \
		--path=/usr/src/wordpress
	wp user create \
		subscriber subscriber@example.com \
		--user_pass=password \
		--role=subscriber \
		--path=/usr/src/wordpress
fi

telegraf &
/usr/sbin/php-fpm7
nginx -g "daemon off;"
