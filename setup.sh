#!/bin/bash

OS="`uname`"
if [[ $OS == "Linux" ]];
then
	DRIVER="docker"
	sed -i -e 's/192.168.99/192.168.49/' srcs/ftps/ftps.yaml
	sed -i -e 's/192.168.99/192.168.49/g' srcs/metallb/metallb.yaml
	sed -i -e 's/192.168.99/192.168.49/' srcs/wordpress/wordpress.yaml
	sed -i -e 's/192.168.99/192.168.49/' srcs/nginx/srcs/index.html
	rm -f srcs/ftps/ftps.yaml-e srcs/metallb/metallb.yaml-e srcs/wordpress/wordpress.yaml-e srcs/nginx/srcs/index.html-e
else
	DRIVER="virtualbox"
	sed -i -e 's/192.168.49/192.168.99/' srcs/ftps/ftps.yaml
	sed -i -e 's/192.168.49/192.168.99/g' srcs/metallb/metallb.yaml
	sed -i -e 's/192.168.49/192.168.99/' srcs/wordpress/wordpress.yaml
	sed -i -e 's/192.168.49/192.168.99/' srcs/nginx/srcs/index.html
	rm -f srcs/ftps/ftps.yaml-e srcs/metallb/metallb.yaml-e srcs/wordpress/wordpress.yaml-e srcs/nginx/srcs/index.html-e
fi

PODS=(nginx)
PODS+=(mysql)
PODS+=(wordpress)
PODS+=(phpmyadmin)
PODS+=(ftps)
PODS+=(grafana)
PODS+=(influxdb)
# PODS+=(telegraf)

function docker_build()
{
	echo "🐳  Building Docker Image for $1"
	docker build -t ft_services/$1 ./srcs/$1 > /dev/null 2>&1
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

echo "███████╗████████╗     ███████╗███████╗██████╗ ██╗   ██╗██╗ ██████╗███████╗███████╗"
echo "██╔════╝╚══██╔══╝     ██╔════╝██╔════╝██╔══██╗██║   ██║██║██╔════╝██╔════╝██╔════╝"
echo "█████╗     ██║        ███████╗█████╗  ██████╔╝██║   ██║██║██║     █████╗  ███████╗"
echo "██╔══╝     ██║        ╚════██║██╔══╝  ██╔══██╗╚██╗ ██╔╝██║██║     ██╔══╝  ╚════██║"
echo "██║        ██║███████╗███████║███████╗██║  ██║ ╚████╔╝ ██║╚██████╗███████╗███████║"
echo "╚═╝        ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚═╝ ╚═════╝╚══════╝╚══════╝"

# delete minikube local status
minikube delete

# start minikube
minikube start --driver=$DRIVER --disk-size=5000mb

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
	echo "🐋  $pod Pod started!"
done

# open dashboard
echo "📊  Activating Minikube Dashboard"
minikube dashboard
