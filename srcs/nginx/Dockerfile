# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tayamamo <tayamamo@student.42tokyo.jp>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/06 20:09:46 by tayamamo          #+#    #+#              #
#    Updated: 2020/12/08 11:05:40 by tayamamo         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

LABEL maintainer="tayamamo <tayamamo@student.42tokyo.jp>"

# Install nginx
RUN set -eux; \
		apk update; \
		apk upgrade; \
		apk add --no-cache nginx openssl openssh; \
		rm -rf /var/cache/apk

# Set up nginx
RUN set -eux; \
		adduser -D -g 'www' www; \
		mkdir /www; \
		chown -R www:www /var/lib/nginx; \
		chown -R www:www /www; \
		mkdir -p /run/nginx

COPY srcs/nginx.conf /etc/nginx/conf.d/default.conf
COPY srcs/index.html /www/index.html
COPY srcs/favicon.ico /www/favicon.ico

# Generate Self-Signed SSL certificate
RUN set -eux; \
		mkdir /etc/ssl/nginx; \
		openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
			-keyout /etc/ssl/private/nginx_private.key \
			-out /etc/ssl/certs/nginx_public.crt \
			-subj "/C=JP/ST=Tokyo/L=Minato-ku/O=42Tokyo/OU=ft_services/CN=localhost"

# Generate SSH Host Key
RUN set -eux; \
		/usr/bin/ssh-keygen -A

# Set up sshd_config
COPY srcs/sshd_config /etc/ssh/

# Install telegraf
RUN echo 'hosts: files dns' >> /etc/nsswitch.conf
RUN apk add --no-cache \
		iputils \
		ca-certificates \
		net-snmp-tools \
		procps \
		lm_sensors \
		tzdata && \
	update-ca-certificates

ENV TELEGRAF_VERSION 1.16.3

RUN set -eux; \
	mkdir ~/.gnupg; \
	echo "disable-ipv6" >> ~/.gnupg/dirmngr.conf; \
	apk add --no-cache --virtual .build-deps wget gnupg tar; \
	for key in \
		05CE15085FC09D18E99EFB22684A14CF2582E0C5 ; \
	do \
		gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key" || \
		gpg --keyserver pgp.mit.edu --recv-keys "$key" || \
		gpg --keyserver keyserver.pgp.com --recv-keys "$key" ; \
	done && \
	wget --no-verbose https://dl.influxdata.com/telegraf/releases/telegraf-${TELEGRAF_VERSION}_static_linux_amd64.tar.gz.asc; \
	wget --no-verbose https://dl.influxdata.com/telegraf/releases/telegraf-${TELEGRAF_VERSION}_static_linux_amd64.tar.gz; \
	gpg --batch --verify telegraf-${TELEGRAF_VERSION}_static_linux_amd64.tar.gz.asc telegraf-${TELEGRAF_VERSION}_static_linux_amd64.tar.gz; \
	mkdir -p /usr/src /etc/telegraf; \
	tar -C /usr/src -xzf telegraf-${TELEGRAF_VERSION}_static_linux_amd64.tar.gz; \
	mv /usr/src/telegraf*/etc/telegraf/telegraf.conf /etc/telegraf/; \
	mkdir /etc/telegraf/telegraf.d; \
	cp -a /usr/src/telegraf*/usr/bin/telegraf /usr/bin/; \
	gpgconf --kill all; \
	rm -rf *.tar.gz* /usr/src /root/.gnupg; \
	apk del .build-deps

EXPOSE 80 443 22

COPY srcs/setup.sh /tmp/setup.sh

RUN chmod +x /tmp/setup.sh

CMD /tmp/setup.sh
