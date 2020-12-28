# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tayamamo <tayamamo@student.42tokyo.jp>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/19 11:02:38 by tayamamo          #+#    #+#              #
#    Updated: 2020/12/28 10:31:31 by tayamamo         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

LABEL maintainer="tayamamo <tayamamo@student.42tokyo.jp>"
LABEL docker.group="ftps-service"

# Install telegraf
RUN echo 'hosts: files dns' >> /etc/nsswitch.conf
RUN apk add --no-cache iputils ca-certificates net-snmp-tools procps lm_sensors tzdata && \
    update-ca-certificates
ENV TELEGRAF_VERSION 1.17.0
RUN set -ex && \
	mkdir ~/.gnupg; \
	echo "disable-ipv6" >> ~/.gnupg/dirmngr.conf; \
	apk add --no-cache --virtual .build-deps wget gnupg tar && \
	for key in \
		05CE15085FC09D18E99EFB22684A14CF2582E0C5 ; \
	do \
		gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key" || \
		gpg --keyserver pgp.mit.edu --recv-keys "$key" || \
		gpg --keyserver keyserver.pgp.com --recv-keys "$key" ; \
	done && \
	wget --no-verbose https://dl.influxdata.com/telegraf/releases/telegraf-${TELEGRAF_VERSION}_static_linux_amd64.tar.gz.asc && \
	wget --no-verbose https://dl.influxdata.com/telegraf/releases/telegraf-${TELEGRAF_VERSION}_static_linux_amd64.tar.gz && \
	gpg --batch --verify telegraf-${TELEGRAF_VERSION}_static_linux_amd64.tar.gz.asc telegraf-${TELEGRAF_VERSION}_static_linux_amd64.tar.gz && \
	mkdir -p /usr/src /etc/telegraf && \
	tar -C /usr/src -xzf telegraf-${TELEGRAF_VERSION}_static_linux_amd64.tar.gz && \
	mv /usr/src/telegraf*/etc/telegraf/telegraf.conf /etc/telegraf/ && \
	mkdir /etc/telegraf/telegraf.d && \
	cp -a /usr/src/telegraf*/usr/bin/telegraf /usr/bin/ && \
	gpgconf --kill all && \
	rm -rf *.tar.gz* /usr/src /root/.gnupg && \
	apk del .build-deps

# Set telegraf configuration
COPY srcs/telegraf.conf /etc/telegraf/

# Install ftps
RUN set -eux; \
	apk -U upgrade; \
	apk add --no-cache \
		vsftpd openssl

# Generate Self-Signed SSL certificate
RUN set -eux; \
		openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
			-keyout /etc/ssl/private/ftps_private.key \
			-out /etc/ssl/certs/ftps_public.crt \
			-subj "/C=JP/ST=Tokyo/L=Minato-ku/O=42Tokyo/OU=ft_services/CN=localhost"

# Set ftps configuration
COPY srcs/vsftpd.conf /etc/vsftpd/

ENV MIN_PORT 21000
ENV MAX_PORT 21005

EXPOSE 21 ${MIN_PORT}-${MAX_PORT}

COPY srcs/setup.sh /tmp/
RUN chmod +x /tmp/setup.sh
CMD /tmp/setup.sh
