#!/usr/bin/env bash

IP=$1

##########################################################################
#
# Start kubernetes service
#
##########################################################################

#Reset kubeadm
echo "reseting kubeadm..."
    kubeadm reset
echo "kubeadm reset complete."

#Starting kubeadm service
echo "starting kubeadm ..."
    kubeadm init  --apiserver-advertise-address=$IP --ignore-preflight-errors Swap

    #if you want to use environment variable without sudo user
    mkdir -p $HOME/.kube
    cp  /etc/kubernetes/admin.conf $HOME/.kube/config
    chown vagrant:vagrant $HOME/.kube/config
 #   export KUBECONFIG=$HOME/.kube/config

   #installing pod network  url https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/#pod-network
    kubectl apply -f https://raw.githubusercontent.com/romana/romana/master/containerize/specs/romana-kubeadm.yml
   # kubectl apply --filename https://git.io/weave-kube-1.6

    #disable taints to execute pods inside master
    kubectl patch node jessie-master -p '{"spec":{"taints":[]}}'
echo "kubeadm started."

echo "installing dashboard ..."
  # follow https://dzone.com/articles/deploying-kubernetes-dashboard-to-a-kubeadm-create

  kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml

  #disable security dashboard
  kubectl apply -f /install/setup-dashboard.yml

  #start proxy
  kubectl proxy --address=$IP --accept-hosts='^*$' &
echo "finish installing dashboard."

echo 'proxy for dashboard'
  sleep 30
  echo "pulse skip button to see dashboard and follow this link"
  echo "http://$IP:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/login"
echo "finish installing dashboard."
