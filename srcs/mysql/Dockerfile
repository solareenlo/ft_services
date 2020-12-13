# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tayamamo <tayamamo@student.42tokyo.jp>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/11 21:38:53 by tayamamo          #+#    #+#              #
#    Updated: 2020/12/13 07:09:12 by tayamamo         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

LABEL maintainer="tayamamo <tayamamo@student.42tokyo.jp>"

RUN set -eux; \
		apk -U upgrade; \
		apk add --no-cache \
			mysql \
			mysql-client

EXPOSE 3306

COPY srcs/setup.sh /tmp/
COPY srcs/initdb.sh /tmp/
COPY srcs/wordpress.sql /tmp/
COPY srcs/my.cnf /etc/

RUN chmod +x /tmp/setup.sh; \
	chmod +x /tmp/initdb.sh; \
	chmod +x /tmp/wordpress.sql

CMD /tmp/setup.sh
