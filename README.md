# kubeadm-vagrant
A vagrant image with kubeadm installation.
There are two virtual machines, one for the master and the other for thes nodes.


**Pre Requisites**

Install vagrant (at least 1.8.1)

**Master**

once you start the machine with 'vagrant up' command you must follow next steps

1 - execute 

_vagrant up_

2 - execute 

_vagrant reload_

3 - execute 

_vagrant ssh_

4 - execute as sudo  

_sudo su && echo 1 > /proc/sys/vm/drop_caches_

5 - execute 

_/install/postinstall.bash_

this commands install kubeadm, kubelet, docker

6 - execute 

_/install/start.bash \<IP>_ for example _./install/start.bash 192.168.1.4_

this commands start kubeadm as master and install dashboard


**Node** 

once you start the machine with 'vagrant up' command you must follow next steps

1 - execute vagrant up

2 - execute vagrant reload

3 - execute vagrant ssh

4 - execute as sudo  

_sudo su && echo 1 > /proc/sys/vm/drop_caches_

5 - execute 

_/install/postinstall.bash_

this commands install kubeadm, kubelet, docker.

6 - execute the join token

_/install/join.bash 'TOKEN'_ for example _kubeadm join 192.168.1.9:6443 --token 3jpzfi.fqyo9k561b34rdd0 --discovery-token-ca-cert-hash sha256:9ed37df6e95bc57453dded04bd3ab0147abde34e32ea444c7fd771d0d6fb830c_ 