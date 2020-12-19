# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tayamamo <tayamamo@student.42tokyo.jp>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/11/28 14:34:11 by tayamamo          #+#    #+#              #
#    Updated: 2020/12/20 01:07:59 by tayamamo         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

OS="`uname`"
if [[ $OS == "Linux" ]];
then
	DRIVER="docker"
else
	DRIVER="virtualbox"
fi

PODS=(nginx)
PODS+=(mysql)
PODS+=(wordpress)
PODS+=(phpmyadmin)

function docker_build()
{
	title="$(tr '[:lower:]' '[:upper:]' <<< ${1:0:1})${1:1}"
	echo "🐳  Building Docker Image for ${title}"
	docker build -t ft_services/$1 $2 ./srcs/$1 > /dev/null 2>&1
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

echo "$WHITE
███████╗████████╗     ███████╗███████╗██████╗ ██╗   ██╗██╗ ██████╗███████╗███████╗
██╔════╝╚══██╔══╝     ██╔════╝██╔════╝██╔══██╗██║   ██║██║██╔════╝██╔════╝██╔════╝
█████╗     ██║        ███████╗█████╗  ██████╔╝██║   ██║██║██║     █████╗  ███████╗
██╔══╝     ██║        ╚════██║██╔══╝  ██╔══██╗╚██╗ ██╔╝██║██║     ██╔══╝  ╚════██║
██║        ██║███████╗███████║███████╗██║  ██║ ╚████╔╝ ██║╚██████╗███████╗███████║
╚═╝        ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚═╝ ╚═════╝╚══════╝╚══════╝$RESET"

# delete minikube local status
minikube delete

# start minikube
minikube start --driver=$DRIVER --disk-size=5000mb

# Delete metallb
# kubectl delete -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
# kubectl delete -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
# kubectl delete -f srcs/metallb/metallb.yaml


# Install metallb
echo "⚖️   Installing MetalLB"
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml > /dev/null 2>&1
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml > /dev/null 2>&1
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" > /dev/null 2>&1
kubectl apply -f srcs/metallb/metallb.yaml > /dev/null 2>&1

# To point your shell to minikube's docker-daemon
eval $(minikube -p minikube docker-env)

for image in "${PODS[@]}"; do
	docker_build $image
done

echo "⛵  Creating Deployments"
kubectl apply -k srcs/ > /dev/null 2>&1
for pod in "${PODS[@]}"; do
	title="$(tr '[:lower:]' '[:upper:]' <<< ${pod:0:1})${pod:1}"
	echo "🐋  $title Pod started!"
done

# open dashboard
# echo "📊  Activating Minikube Dashboard"
# minikube dashboard
