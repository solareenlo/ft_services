# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tayamamo <tayamamo@student.42tokyo.jp>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/11/28 14:34:11 by tayamamo          #+#    #+#              #
#    Updated: 2020/12/08 21:22:02 by tayamamo         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

PODS=(nginx)

function deploy()
{
	errlog=$(mktemp)
	docker build -t ft_services/$1 ./srcs/$1
	sleep 1
	kubectl apply -f ./srcs/$1/$1.yaml
	if [[ -s $errlog ]]; then
		echo "$1 Pod started!"
	else
		kubectl delete pod -n default -l app=$1
		echo "Pod restarted!"
	fi
	rm -f $errlog
	return 0
}

# Colors
BLACK='\033[30m'
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
BLUE='\033[34m'
PURPLE='\033[35m'
CYAN='\033[36m'
WHITE='\033[37m'
RESET='\033[0m'

echo "${GREEN}Starting minikube...${RESET}"

# delete minikube local status
# minikube delete

# start minikube
# minikube start --driver=virtualbox

# To point your shell to minikube's docker-daemon
eval $(minikube -p minikube docker-env)

for image in "${PODS[@]}"
do
	deploy $image
done

echo "$WHITE
███████╗████████╗     ███████╗███████╗██████╗ ██╗   ██╗██╗ ██████╗███████╗███████╗
██╔════╝╚══██╔══╝     ██╔════╝██╔════╝██╔══██╗██║   ██║██║██╔════╝██╔════╝██╔════╝
█████╗     ██║        ███████╗█████╗  ██████╔╝██║   ██║██║██║     █████╗  ███████╗
██╔══╝     ██║        ╚════██║██╔══╝  ██╔══██╗╚██╗ ██╔╝██║██║     ██╔══╝  ╚════██║
██║        ██║███████╗███████║███████╗██║  ██║ ╚████╔╝ ██║╚██████╗███████╗███████║
╚═╝        ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚═╝ ╚═════╝╚══════╝╚══════╝
$RESET"

# open dashboard
# minikube dashboard
