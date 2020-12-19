# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tayamamo <tayamamo@student.42tokyo.jp>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/19 11:02:38 by tayamamo          #+#    #+#              #
#    Updated: 2020/12/19 20:03:04 by tayamamo         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

LABEL maintainer="tayamamo <tayamamo@student.42tokyo.jp>"

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

COPY srcs/setup.sh /tmp/
RUN chmod +x /tmp/setup.sh

COPY srcs/vsftpd.conf /etc/vsftpd/

ENV MIN_PORT 21000
ENV MAX_PORT 21005

EXPOSE 21 ${MIN_PORT}-${MAX_PORT}

ENTRYPOINT ["/tmp/setup.sh"]
