#!/bin/sh

adduser -D "$SSH_USER"
echo "$SSH_USER:$SSH_PASSWORD" | chpasswd

/usr/sbin/sshd

telegraf &
/usr/sbin/php-fpm7
nginx -g "daemon off;"
