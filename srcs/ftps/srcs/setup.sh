#!/bin/sh

# Start telegraf
telegraf &

# FTPS_USER=admin
# FTPS_PASSWORD=password
# ADDRESS=192.168.99.10
# MIN_PORT=21000
# MAX_PORT=21005
# ADDR_OPT="-opasv_address=$ADDRESS"

mkdir -p /var/ftps
# Create ftps user without creating a home directory
adduser -D --home /var/ftps/"$USERNAME" "$USERNAME"
chmod a+w /var/ftps/"$USERNAME"
# Update password for the ftps user
echo "$USERNAME:$PASSWORD" | chpasswd
echo "$USERNAME" > /etc/vsftpd.chroot_list

/usr/sbin/vsftpd \
	-opasv_min_port=$MIN_PORT \
	-opasv_max_port=$MAX_PORT \
	-opasv_address=$ADDRESS \
	/etc/vsftpd/vsftpd.conf
