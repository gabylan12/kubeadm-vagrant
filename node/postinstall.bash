#!/bin/bash

#sudo su && echo 1 > /proc/sys/vm/drop_caches
#INSTALL kubeadm https://kubernetes.io/docs/setup/independent/install-kubeadm/
echo "Installing kubeadm ...."
	apt-get update && apt-get install -y curl apt-transport-https 
	curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
	echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" >> /etc/apt/sources.list.d/kubernetes.list
	apt-get update
	apt-get install -y kubelet kubeadm kubectl

	echo "cgroup-driver=cgroupfs" >> /etc/systemd/system/kubelet.service.d/10-kubeadm.conf#    
	echo 'Environment="KUBELET_EXTRA_ARGS=--fail-swap-on=false"' >> /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
echo "finish kubeadm installation."

#Install docker
echo "installing docker ..."
	apt-get install -y apt-transport-https ca-certificates curl software-properties-common
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
	add-apt-repository "deb https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"
	apt-get update && apt-get install -y docker-ce=$(apt-cache madison docker-ce | grep 17.03 | head -1 | awk '{print $3}')
echo "finish installing docker."

#Reloading kubelet service
echo "reloading kubelet..."
    systemctl daemon-reload
    systemctl restart kubelet
    export KUBECONFIG=/etc/kubernetes/admin.config
echo "finish kubelet reload."


