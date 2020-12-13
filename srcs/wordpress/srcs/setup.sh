# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tayamamo <tayamamo@student.42tokyo.jp>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/13 09:30:10 by tayamamo          #+#    #+#              #
#    Updated: 2020/12/13 21:36:10 by tayamamo         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

cat > /tmp/sql << EOF
CREATE DATABASE IF NOT EXISTS $DATABASE_NAME;
CREATE USER '$USERNAME'@'$WORDPRESS_SERVICE_HOST' IDENTIFIED BY '$PASSWORD';
GRANT ALL PRIVILEGES ON $DATABASE_NAME.* TO '$USERNAME'@'$WORDPRESS_SERVICE_HOST';
EOF

mysql --host=$WORDPRESS_DB_HOST --user=root --password=$MYSQL_ROOT_PASSWORD < /tmp/sql
rm /tmp/sql

adduser --no-create-home -D $USERNAME
echo "$USERNAME:$PASSWORD" | chpasswd
chmod -R 755 /var/www/
chown -R $USERNAME:$USERNAME /var/www/wordpress

sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo=$PHP_CGI_FIX_PATHINFO|i" /etc/php7/php.ini

/usr/bin/supervisord -c /etc/supervisor.d/supervisor.ini
