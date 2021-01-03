# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tayamamo <tayamamo@student.42tokyo.jp>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/21 20:39:46 by tayamamo          #+#    #+#              #
#    Updated: 2021/01/03 18:49:53 by tayamamo         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

LABEL Maintainer="tayamamo <tayamamo@student.42tokyo.jp>"

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

RUN set -eux; \
	apk -U upgrade; \
	apk add --no-cache \
		openssl

# Generate Self-Signed SSL certificate
RUN set -eux; \
		openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
			-keyout /etc/ssl/private/grafana_private.key \
			-out /etc/ssl/certs/grafana_public.crt \
			-subj "/C=JP/ST=Tokyo/L=Minato-ku/O=42Tokyo/OU=ft_services/CN=localhost"

# Install libc
COPY srcs/glibc-2.32-r0.apk /tmp/

RUN set -eux; \
	apk -U upgrade && \
	wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
	# wget -O /tmp/glibc-2.32-r0.apk \
	# 	https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.32-r0/glibc-2.32-r0.apk && \
	apk add --no-cache /tmp/glibc-2.32-r0.apk && \
	rm /tmp/*

# Install grafana
ENV GRAFANA_VERSION 7.3.6
ENV GRAFANA_SHA256 2eb4e5a2aa3990a5299fd40b41a1fedf8fad53a8dfb144b60d804d9cc6b384ba
ENV GRAFANA_FILE_NAME grafana-${GRAFANA_VERSION}.linux-amd64.tar.gz

COPY srcs/${GRAFANA_FILE_NAME} /tmp/

RUN set -eux; \
	# wget -O /tmp/${GRAFANA_FILE_NAME} \
	# 	https://dl.grafana.com/oss/release/${GRAFANA_FILE_NAME} && \
	echo "$GRAFANA_SHA256 */tmp/${GRAFANA_FILE_NAME}" | sha256sum -c -; \
	mkdir /usr/share/grafana && \
	tar -zxvf /tmp/${GRAFANA_FILE_NAME} --strip-components=1 -C /usr/share/grafana && \
	rm /tmp/*

# Set grafana configuration
RUN mkdir /etc/grafana
COPY srcs/custom.ini /usr/share/grafana/conf
COPY srcs/telegraf-system-dashboard.json /var/lib/grafana/dashboards/home.json
COPY srcs/datasources.yaml /usr/share/grafana/conf/provisioning/datasources/
COPY srcs/dashboards.yaml /usr/share/grafana/conf/provisioning/dashboards/

# Set healthcheck
COPY srcs/healthcheck.sh /tmp/
RUN chmod +x /tmp/healthcheck.sh

EXPOSE 3000

COPY srcs/setup.sh /tmp/
RUN chmod +x /tmp/setup.sh
CMD /tmp/setup.sh
