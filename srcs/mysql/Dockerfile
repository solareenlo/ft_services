# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tayamamo <tayamamo@student.42tokyo.jp>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/11 21:38:53 by tayamamo          #+#    #+#              #
#    Updated: 2020/12/25 05:12:01 by tayamamo         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

LABEL maintainer="tayamamo <tayamamo@student.42tokyo.jp>"
LABEL docker.group="wordpress-mysql"

RUN set -eux; \
		apk -U upgrade; \
		apk add --no-cache \
			mysql \
			mysql-client

EXPOSE 3306

COPY srcs/setup.sh /tmp/
COPY srcs/my.cnf /etc/
COPY srcs/create_tables.sql /tmp/

RUN chmod +x /tmp/setup.sh

VOLUME /var/lib/mysql

CMD /tmp/setup.sh
