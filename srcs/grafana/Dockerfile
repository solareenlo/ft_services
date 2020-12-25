# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tayamamo <tayamamo@student.42tokyo.jp>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/21 20:39:46 by tayamamo          #+#    #+#              #
#    Updated: 2020/12/25 16:35:45 by tayamamo         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

LABEL Maintainer="tayamamo <tayamamo@student.42tokyo.jp>"
LABEL docker.group="grafana-service"

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
ENV DS_INFLUXDB_TELEGRAF="InfluxDB telegraf"
RUN mkdir /etc/grafana
COPY srcs/custom.ini /usr/share/grafana/conf
COPY srcs/telegraf-system-dashboard_rev4.json /var/lib/grafana/dashboards/home.json
RUN ln -sf /var/lib/grafana/dashboards/home.json /usr/share/grafana/public/dashboards/home.json
COPY srcs/datasources.yaml /usr/share/grafana/conf/provisioning/datasources/
COPY srcs/dashboards.yaml /usr/share/grafana/conf/provisioning/dashboards/

EXPOSE 3000

COPY srcs/setup.sh /tmp/
RUN chmod +x /tmp/setup.sh
CMD /tmp/setup.sh
