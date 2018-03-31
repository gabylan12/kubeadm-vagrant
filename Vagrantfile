
Vagrant.configure(2) do |config|
  config.vm.box = "debian/jessie64"

   config.vm.box_check_update = false

   config.vm.network "public_network"
   config.vm.provision "shell", inline: <<-SHELL
     #INSTALL kubeadm https://kubernetes.io/docs/setup/independent/install-kubeadm/
     echo "Installing kubeadm ...."
     apt-get update && apt-get install -y apt-transport-https curl
     curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
     echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" >> /etc/apt/sources.list.d/kubernetes.list
     apt-get update
     apt-get install -y kubelet kubeadm kubectl

     echo "cgroup-driver=cgroupfs" >> /etc/systemd/system/kubelet.service.d/10-kubeadm.conf

     echo "finish kubeadm installation."

     echo "reloading kubelet..."
     systemctl daemon-reload
     systemctl restart kubelet
     echo "finish kubelet reload."

     #Install docker
     echo "installing docker ..."
     apt-get install -y apt-transport-https ca-certificates software-properties-common
     curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
     add-apt-repository "deb https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"
     apt-get update && apt-get install -y docker-ce=$(apt-cache madison docker-ce | grep 17.03 | head -1 | awk '{print $3}')
     echo "finish installing docker."

     echo "starting kubeadm ..."
     sudo kubeadm init --skip-preflight-checks
     echo "kubeadm started."
 SHELL
end
