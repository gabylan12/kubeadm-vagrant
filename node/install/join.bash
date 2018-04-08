#!/usr/bin/env bash

##########################################################################
#
# Join the node to a master
#
##########################################################################

TOKEN=$1

#join to master node
echo "joining master node..."
$TOKEN --ignore-preflight-errors Swap
echo "finish join."