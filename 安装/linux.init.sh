cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

# 设置所需的 sysctl 参数，参数在重新启动后保持不变
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# 应用 sysctl 参数而不重新启动
sudo sysctl --system

echo '桥接流量 done'

timedatectl set-timezone Asia/Shanghai
date -R

echo '时区 done'

# 升级firewalld
yum update -y firewalld
# 局域网放行
sudo firewall-cmd --zone=public --add-rich-rule='rule family="ipv4" source address="192.168.50.0/24" port protocol="tcp" port="2000-30000" accept' --permanent
sudo firewall-cmd --zone=public --add-rich-rule='rule family="ipv4" source address="192.168.50.0/24" port protocol="udp" port="2000-30000" accept' --permanent
# 重新加载防火墙配置
sudo firewall-cmd --reload

echo 'firewall done'

swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

echo 'swap done'


setenforce 0
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

echo 'selinux done'


yum install -y yum-utils
yum-config-manager \
  --add-repo \
  https://download.docker.com/linux/centos/docker-ce.repo
yum install -y containerd.io
systemctl enable --now containerd

echo 'containerd done'


wget https://github.com/containerd/nerdctl/releases/download/v1.3.1/nerdctl-full-1.3.1-linux-amd64.tar.gz
tar -xzvf nerdctl-full-1.3.1-linux-amd64.tar.gz -C /usr/local
nerdctl run hello-world

echo 'nerdctl done'

cat <<EOF | tee /etc/containerd/config.toml
disabled_plugins = ["zfs", "devmapper"]
[plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc]
[plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options]
SystemdCgroup = true
[plugins."io.containerd.grpc.v1.cri"]
sandbox_image = "registry.k8s.io/pause:3.2"
EOF

systemctl restart containerd

echo 'containerd config done'


cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kubelet kubeadm kubectl
EOF

sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes

sudo systemctl enable --now kubelet

echo 'kubelet done'

