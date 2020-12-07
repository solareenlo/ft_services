# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tayamamo <tayamamo@student.42tokyo.jp>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/11/28 14:34:11 by tayamamo          #+#    #+#              #
#    Updated: 2020/12/07 17:35:33 by tayamamo         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

PODS=(nginx)

function deploy()
{
	docker build -t my_$1 ./srcs/$1
}

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RESET='\033[0;0m'

echo "${GREEN}Starting minikube...${RESET}"

# delete minikube local status
# minikube delete

# start minikube
# minikube start --driver=virtualbox

# To point your shell to minikube's docker-daemon
# eval $(minikube -p minikube docker-env)

for image in "${PODS[@]}"
do
	deploy $image
done

# open dashboard
# minikube dashboard
