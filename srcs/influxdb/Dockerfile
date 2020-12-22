# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tayamamo <tayamamo@student.42tokyo.jp>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/22 04:18:17 by tayamamo          #+#    #+#              #
#    Updated: 2020/12/22 17:26:42 by tayamamo         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

LABEL Maintainer="tayamamo <tayamamo@student.42tokyo.jp>"

RUN echo 'hosts: files dns' >> /etc/nsswitch.conf
RUN apk -U upgrade; \
	apk add --no-cache tzdata bash ca-certificates openssl && \
    update-ca-certificates

# Generate Self-Signed SSL certificate
RUN set -eux; \
		openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
			-keyout /etc/ssl/private/influxdb_private.key \
			-out /etc/ssl/certs/influxdb_public.crt \
			-subj "/C=JP/ST=Tokyo/L=Minato-ku/O=42Tokyo/OU=ft_services/CN=localhost"

# Set configuration
RUN mkdir /etc/influxdb
ENV INFLUXD_CONFIG_PATH /etc/influxdb
COPY srcs/config.yaml /etc/influxdb/

# Install influxdb
ENV INFLUXDB_VERSION 2.0.3

COPY srcs/influxdb2-${INFLUXDB_VERSION}_linux_amd64.tar.gz /tmp/

RUN set -eux && \
	mkdir ~/.gnupg; \
	echo "disable-ipv6" >> ~/.gnupg/dirmngr.conf; \
	apk add --no-cache --virtual .build-deps wget gnupg tar curl && \
	curl -s https://repos.influxdata.com/influxdb2.key | gpg --import - && \
	wget --no-verbose https://dl.influxdata.com/influxdb/releases/influxdb2-${INFLUXDB_VERSION}_linux_amd64.tar.gz.asc -P /tmp/ && \
	# wget --no-verbose https://dl.influxdata.com/influxdb/releases/influxdb2-${INFLUXDB_VERSION}_linux_amd64.tar.gz -P /tmp/ && \
	gpg --batch --verify /tmp/influxdb2-${INFLUXDB_VERSION}_linux_amd64.tar.gz.asc /tmp/influxdb2-${INFLUXDB_VERSION}_linux_amd64.tar.gz && \
	mkdir -p /usr/src && \
	tar -C /usr/src -xzf /tmp/influxdb2-${INFLUXDB_VERSION}_linux_amd64.tar.gz && \
	rm -f /usr/src/influxdb2-*/influxdb.conf && \
	chmod +x /usr/src/influxdb2-*/* && \
	cp -a /usr/src/influxdb2-*/* /usr/bin/ && \
	gpgconf --kill all && \
	rm -rf /tmp/*.tar.gz* /usr/src /root/.gnupg && \
	apk del .build-deps

EXPOSE 8086

VOLUME /var/lib/influxdb

COPY srcs/setup.sh /tmp/
RUN chmod +x /tmp/setup.sh
# COPY init-influxdb.sh /init-influxdb.sh
# ENTRYPOINT ["/entrypoint.sh"]
CMD /tmp/setup.sh
