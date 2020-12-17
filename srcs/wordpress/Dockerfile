# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tayamamo <tayamamo@student.42tokyo.jp>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/14 21:42:24 by tayamamo          #+#    #+#              #
#    Updated: 2020/12/17 10:35:23 by tayamamo         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

LABEL Maintainer="tayamamo <tayamamo@student.42tokyo.jp>"

RUN set -eux; \
	apk -U upgrade && \
	apk add --no-cache \
		php7 \
		php7-fpm \
		php7-curl \
		php7-dom \
		php7-exif \
		php7-fileinfo \
		php7-json \
		php7-mbstring \
		php7-mysqli \
		php7-sodium \
		php7-openssl \
		php7-imagick \
		php7-xml \
		php7-zip \
		php7-gd \
		php7-iconv \
		php7-mcrypt \
		php7-simplexml \
		php7-xmlreader \
		php7-xmlwriter \
		php7-zlib \
		php7-phar \
		php7-intl \
		php7-ctype \
		php7-opcache \
		nginx \
		mysql-client \
		curl

# Set up nginx
COPY srcs/nginx.conf /etc/nginx/conf.d/default.conf
RUN set -eux; \
		mkdir -p /run/nginx

# VOLUME ["/var/www/wp-content"]
# WORKDIR /var/www/wp-content
# RUN chown -R nobody.nobody /var/www

# Install wordpress
ENV WORDPRESS_VERSION 5.6
ENV WORDPRESS_SHA1 db8b75bfc9de27490434b365c12fd805ca6784ce

COPY srcs/wordpress-${WORDPRESS_VERSION}.tar.gz /tmp/wordpress.tar.gz

RUN set -ex; \
	# curl -o /tmp/wordpress.tar.gz -fSL "https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz"; \
	echo "$WORDPRESS_SHA1 */tmp/wordpress.tar.gz" | sha1sum -c -; \
	mkdir -p /usr/src; \
	tar -xzf /tmp/wordpress.tar.gz -C /usr/src/; \
	rm /tmp/wordpress.tar.gz; \
	chown -R nobody:nobody /usr/src/wordpress

# Install WP CLI
RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x /usr/local/bin/wp

# Set up wp-config
# COPY srcs/wp-config.php /usr/src/wordpress
# RUN chown nobody.nobody /usr/src/wordpress/wp-config.php && \
# 	chmod 640 /usr/src/wordpress/wp-config.php

# Add wp-secret-keys
COPY srcs/wp-secret-keys.php /usr/src/wordpress
RUN chown nobody.nobody /usr/src/wordpress/wp-secret-keys.php && \
	chmod 640 /usr/src/wordpress/wp-secret-keys.php

COPY srcs/healthcheck.sh /tmp/healthcheck.sh
RUN chmod +x /tmp/healthcheck.sh

# COPY srcs/entrypoint.sh /tmp/entrypoint.sh
# RUN chmod +x /tmp/entrypoint.sh
# ENTRYPOINT /tmp/entrypoint.sh

EXPOSE 5050

# Run CMD
COPY srcs/setup.sh /tmp/setup.sh
RUN chmod +x /tmp/setup.sh
CMD /tmp/setup.sh
