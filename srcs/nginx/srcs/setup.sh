#!/bin/sh

adduser -D "$SSH_USER"
echo "$SSH_USER:$SSH_PASSWORD" | chpasswd

telegraf &
/usr/sbin/sshd
/usr/sbin/php-fpm7
nginx -g "daemon off;"
