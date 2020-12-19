#!/bin/sh

# Start telegraf
# telegraf &

/usr/sbin/php-fpm7

# Create ssh user without creating a home directory
adduser -D "$SSH_USER"
# Update password for the ssh user
echo "$SSH_USER:$SSH_PASSWORD" | chpasswd

# sshd is the daemon program for ssh connection
/usr/sbin/sshd

# For normal prduction (on a server), use the default daemon on;
# In this case of Docker containers(or for debugging), use the daemon off;
nginx -g "daemon off;"
