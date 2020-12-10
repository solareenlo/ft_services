FROM alpine:3.12

RUN set -x && \
	apk update && \
	apk upgrade && \
	apk add --no-cache openssh openrc

# For debug
# RUN apk add --no-cache bash vim

RUN rc-update add sshd && rc-status
RUN mkdir -p /run/openrc/ && touch /run/openrc/softlevel

# Enable Port Forwarding
RUN sed -i 's/^#Port 22/Port 22/g' /etc/ssh/sshd_config; \
	sed -i 's/^AllowTcpForwarding no/AllowTcpForwarding yes/g' /etc/ssh/sshd_config; \
	sed -i 's/^GatewayPorts no/GatewayPorts yes/g' /etc/ssh/sshd_config; \
	sed -i 's/^X11Forwarding no/X11Forwarding yes/g' /etc/ssh/sshd_config

RUN adduser -D ssh-user
# It will cause an ssh login error if user has no password
RUN echo "ssh-user:ssh-pass" | chpasswd
# If need sudo
# RUN apk add --no-cache sudo
# RUN echo "ssh-user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ssh-user
RUN mkdir $HOME/.ssh
RUN ssh-keygen -m PEM -t rsa -b 1024 -C "ssh-user@example.com" -N "" -f $HOME/.ssh/id_rsa
RUN cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys

USER root
RUN cp /home/ssh-user/.ssh/id_rsa $HOME/ssh-user.pem

CMD /etc/init.d/sshd start
