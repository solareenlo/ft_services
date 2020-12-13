# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tayamamo <tayamamo@student.42tokyo.jp>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/13 05:33:55 by tayamamo          #+#    #+#              #
#    Updated: 2020/12/13 19:03:12 by tayamamo         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!bin/sh

mysql_install_db --user=root --ldata=/var/lib/mysql

cat > /tmp/sql << EOF
USE mysql;
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY "$MYSQL_ROOT_PASSWORD" WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
ALTER USER 'root'@'localhost' IDENTIFIED BY '';
DROP DATABASE IF EXISTS test;
EOF

/usr/bin/mysqld --user=root --console --init_file=/tmp/sql

rm /tmp/sql
