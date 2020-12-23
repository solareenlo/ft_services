# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tayamamo <tayamamo@student.42tokyo.jp>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/06 20:09:46 by tayamamo          #+#    #+#              #
#    Updated: 2020/12/23 22:39:05 by tayamamo         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

LABEL maintainer="tayamamo <tayamamo@student.42tokyo.jp>"

# Install nginx, ssl, ssh
RUN set -eux; \
		apk -U upgrade; \
		apk add --no-cache \
			nginx \
			openssl \
			openssh

# Set up nginx
RUN set -eux; \
		mkdir -p /var/run/nginx

COPY srcs/nginx.conf /etc/nginx/conf.d/default.conf
COPY srcs/index.html /var/www/index.html
COPY srcs/favicon.ico /var/www/favicon.ico

# Generate Self-Signed SSL certificate
RUN set -eux; \
		openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
			-keyout /etc/ssl/private/nginx_private.key \
			-out /etc/ssl/certs/nginx_public.crt \
			-subj "/C=JP/ST=Tokyo/L=Minato-ku/O=42Tokyo/OU=ft_services/CN=localhost"

# Generate SSH Host Key
RUN set -eux; \
		/usr/bin/ssh-keygen -A

# Set up sshd_config
COPY srcs/sshd_config /etc/ssh/

EXPOSE 80 443 22

COPY srcs/setup.sh /tmp/
RUN chmod +x /tmp/setup.sh
CMD /tmp/setup.sh
