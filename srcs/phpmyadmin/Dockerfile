# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tayamamo <tayamamo@student.42tokyo.jp>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/17 14:52:26 by tayamamo          #+#    #+#              #
#    Updated: 2020/12/25 04:37:18 by tayamamo         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

LABEL maintainer="tayamamo <tayamamo@student.42tokyo.jp>"
LABEL docker.group="wordpress-phpmyadmin"

RUN set -eux; \
		apk -U upgrade; \
		apk add --no-cache \
			gnupg nginx php7-fpm php7-common php7-iconv php7-json php7-gd \
			php7-curl php7-xml php7-mysqli php7-imap php7-pdo php7-pdo_mysql \
			php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext \
			php7-ldap php7-ctype php7-dom php7-session php7-mbstring \
			curl bash openssl

# Set up nginx
COPY srcs/nginx.conf /etc/nginx/conf.d/default.conf
RUN set -eux; \
		mkdir -p /run/nginx

# Generate Self-Signed SSL certificate
RUN set -eux; \
		openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
			-keyout /etc/ssl/private/nginx_private.key \
			-out /etc/ssl/certs/nginx_public.crt \
			-subj "/C=JP/ST=Tokyo/L=Minato-ku/O=42Tokyo/OU=ft_services/CN=localhost"

# Install phpmayadmin
ENV VERSION 5.0.4
ENV SHA256 1578c1a08e594da4f4f62e676ccbdbd17784c3de769b094ba42c35bf05c057db
ENV URL https://files.phpmyadmin.net/phpMyAdmin/${VERSION}/phpMyAdmin-${VERSION}-all-languages.tar.xz

RUN set -ex; \
    apk add --no-cache --virtual .fetch-deps \
        gnupg \
    ; \
    \
    export GNUPGHOME="$(mktemp -d)"; \
    export GPGKEY="3D06A59ECE730EB71B511C17CE752F178259BD92"; \
    curl -fsSL -o phpMyAdmin.tar.xz $URL; \
    curl -fsSL -o phpMyAdmin.tar.xz.asc $URL.asc; \
    echo "$SHA256 *phpMyAdmin.tar.xz" | sha256sum -c -; \
    gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys "$GPGKEY" \
        || gpg --batch --keyserver ipv4.pool.sks-keyservers.net --recv-keys "$GPGKEY" \
        || gpg --batch --keyserver keys.gnupg.net --recv-keys "$GPGKEY" \
        || gpg --batch --keyserver pgp.mit.edu --recv-keys "$GPGKEY" \
        || gpg --batch --keyserver keyserver.pgp.com --recv-keys "$GPGKEY"; \
    gpg --batch --verify phpMyAdmin.tar.xz.asc phpMyAdmin.tar.xz; \
	mkdir -p /var/www/html; \
    tar -xf phpMyAdmin.tar.xz -C /var/www/html --strip-components=1; \
    mkdir -p /var/www/html/tmp; \
    chown nobody:nobody /var/www/html/tmp; \
    gpgconf --kill all; \
    rm -r "$GNUPGHOME" phpMyAdmin.tar.xz phpMyAdmin.tar.xz.asc; \
    rm -rf /var/www/html/setup/\
		   /var/www/html/examples/\
		   /var/www/html/test/\
		   /var/www/html/po/\
		   /var/www/html/composer.json\
		   /var/www/html/RELEASE-DATE-$VERSION; \
    sed -i "s@define('CONFIG_DIR'.*@define('CONFIG_DIR', '/etc/phpmyadmin/');@" /var/www/html/libraries/vendor_config.php; \
    apk del --no-network .fetch-deps

# Copy configuration
COPY srcs/config.inc.php /etc/phpmyadmin/config.inc.php

RUN touch /etc/phpmyadmin/config.secret.inc.php

EXPOSE 5000

COPY srcs/setup.sh /tmp/
RUN chmod +x /tmp/setup.sh
CMD ["/tmp/setup.sh"]
