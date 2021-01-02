#!/bin/sh

mkdir -p /var/ftps
# Create ftps user without creating a home directory
adduser -D --home /var/ftps/"$USERNAME" "$USERNAME"
chmod a+w /var/ftps/"$USERNAME"
# Update password for the ftps user
echo "$USERNAME:$PASSWORD" | chpasswd
echo "$USERNAME" > /etc/vsftpd.chroot_list

telegraf &
/usr/sbin/vsftpd \
	-opasv_min_port=$MIN_PORT \
	-opasv_max_port=$MAX_PORT \
	-opasv_address=$ADDRESS \
	/etc/vsftpd/vsftpd.conf
