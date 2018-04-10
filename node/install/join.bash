#!/usr/bin/env bash

##########################################################################
#
# Join the node to a master
#
##########################################################################

TOKEN=$1

#reset previous configuration
echo "reset configuration ..."
kubeadm reset
echo "finish reset."

#join to master node
echo "joining master node..."
$TOKEN --ignore-preflight-errors Swap
echo "finish join."