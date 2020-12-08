# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tayamamo <tayamamo@student.42tokyo.jp>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/08 19:13:13 by tayamamo          #+#    #+#              #
#    Updated: 2020/12/08 20:21:14 by tayamamo         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

# Start telegraf
# telegraf &

# Create new user without creating a home directory
adduser -D "$SSH_USER"
# Update password for the new user
echo "$SSH_USER:$SSH_PASSWORD" | chpasswd

# sshd is the daemon program for ssh connection
/usr/sbin/sshd

# For normal prduction (on a server), use the default daemon on;
# In this case of Docker containers(or for debugging), use the daemon off;
nginx -g "daemon off;"
