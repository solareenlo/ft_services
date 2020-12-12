# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tayamamo <tayamamo@student.42tokyo.jp>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/12 11:28:16 by tayamamo          #+#    #+#              #
#    Updated: 2020/12/12 17:02:17 by tayamamo         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

nohup /tmp/initdb.sh > /dev/null 2>&1 &

sed -i 's/skip-networking/#skip-networking/g' /etc/my.cnf.d/mariadb-server.cnf

mysql_install_db --user=mysql --ldata='/var/lib/mysql'

/usr/bin/mysqld_safe --datadir='/var/lib/mysql'
