# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tayamamo <tayamamo@student.42tokyo.jp>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/10 10:49:42 by tayamamo          #+#    #+#              #
#    Updated: 2020/12/12 13:14:26 by tayamamo         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

LABEL maintainer="tayamamo <tayamamo@student.42tokyo.jp>"

RUN set -eux; \
		apk -U upgrade; \
		apk add --no-cache \
			php7 \
			php7-fpm \
			php7-mysqli \
			php7-json \
			php7-openssl \
			php7-curl \
			php7-zlib \
			php7-xml \
			php7-phar \
			php7-intl \
			php7-dom \
			php7-xmlreader \
			php7-xmlwriter \
			php7-exif \
			php7-fileinfo \
			php7-sodium \
			php7-openssl \
			php7-gd \
			php7-imagick \
			php7-simplexml \
			php7-ctype \
			php7-mbstring \
			php7-zip \
			php7-opcache \
			nginx \
			supervisor

# Set up nginx
RUN set -eux; \
		mkdir -p /run/nginx

COPY srcs/nginx.conf /etc/nginx/conf.d/default.conf

# Install wordpress
ENV WORDPRESS_VERSION 5.6
ENV WORDPRESS_SHA1 db8b75bfc9de27490434b365c12fd805ca6784ce

COPY srcs/wordpress-${WORDPRESS_VERSION}.tar.gz /tmp/wordpress.tar.gz

RUN set -ex; \
	# curl -o /tmp/wordpress.tar.gz -fSL "https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz"; \
	echo "$WORDPRESS_SHA1 */tmp/wordpress.tar.gz" | sha1sum -c -; \
	tar -xzf /tmp/wordpress.tar.gz -C /var/www/; \
	rm /tmp/wordpress.tar.gz

EXPOSE 5050

COPY ./srcs/supervisor.ini /etc/supervisor.d/

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor.d/supervisor.ini"]
