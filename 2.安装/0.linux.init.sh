#! /bin/bash
set -e

# update
dnf update -y
echo -e "\033[32m dnf update deno \033[0m"

# 设置所需的 sysctl 参数，参数在重新启动后保持不变
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.conf.all.forwarding        = 1
net.ipv6.conf.all.forwarding        = 1
EOF
# 应用 sysctl 参数而不重新启动
sudo sysctl --system
echo -e "\033[32m 桥接流量 deno \033[0m"

timedatectl set-timezone Asia/Shanghai
date -R
echo -e "\033[32m 时区 deno \033[0m"

systemctl disable --now firewalld
echo -e "\033[32m firewall deno \033[0m"

swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
echo -e "\033[32m swap off deno \033[0m"

setenforce 0
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config
echo -e "\033[32m selinux off deno \033[0m"

# install containerd
OS=linux
ARCH=amd64
CONTAINERD_VERSION=1.7.18
curl -OL https://github.com/containerd/containerd/releases/download/v${CONTAINERD_VERSION}/containerd-${CONTAINERD_VERSION}-${OS}-${ARCH}.tar.gz
tar Cxzvf /usr/local containerd-${CONTAINERD_VERSION}-${OS}-${ARCH}.tar.gz
echo -e "\033[32m containerd deno \033[0m"

curl -L https://raw.githubusercontent.com/containerd/containerd/main/containerd.service -o /etc/systemd/system/containerd.service
systemctl daemon-reload
systemctl enable --now containerd
echo -e "\033[32m containerd service deno \033[0m"

# install runc
RUNC_VERSION=1.1.13
curl -OL https://github.com/opencontainers/runc/releases/download/v${RUNC_VERSION}/runc.${ARCH}
install -m 755 runc.amd64 /usr/local/sbin/runc
echo -e "\033[32m runc deno \033[0m"

# cni 插件
CNI_VERSION=1.5.0
mkdir -p /opt/cni/bin
curl -OL https://github.com/containernetworking/plugins/releases/download/v${CNI_VERSION}/cni-plugins-${OS}-${ARCH}-v${CNI_VERSION}.tgz
tar Cxzvf /opt/cni/bin cni-plugins-${OS}-${ARCH}-v${CNI_VERSION}.tgz
echo -e "\033[32m cni deno \033[0m"

# 配置 containerd
mkdir -p /etc/containerd
containerd config default > /etc/containerd/config.toml
sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
systemctl restart containerd
echo -e "\033[32m containerd config deno \033[0m"

VERSION="v1.26.0" # check latest version in /releases page
curl -L https://github.com/kubernetes-sigs/cri-tools/releases/download/$VERSION/crictl-${VERSION}-linux-amd64.tar.gz --output crictl-${VERSION}-linux-amd64.tar.gz
tar zxvf crictl-$VERSION-linux-amd64.tar.gz -C /usr/local/bin
rm -f crictl-$VERSION-linux-amd64.tar.gz
echo -e "\033[32m crictl deno \033[0m"

dnf -y install conntrack socat
echo -e "\033[32m conntrack  socat deno \033[0m"

RELEASE="v1.30.2"
ARCH="amd64"
DOWNLOAD_DIR="/usr/local/bin"
cd $DOWNLOAD_DIR
curl -L --remote-name-all https://cdn.dl.k8s.io/release/${RELEASE}/bin/linux/${ARCH}/{kubeadm,kubelet,kubectl}
chmod +x {kubeadm,kubelet,kubectl}

RELEASE_VERSION="v0.16.2"
curl -sSL "https://raw.githubusercontent.com/kubernetes/release/${RELEASE_VERSION}/cmd/krel/templates/latest/kubelet/kubelet.service" | sed "s:/usr/bin:${DOWNLOAD_DIR}:g" | sudo tee /etc/systemd/system/kubelet.service
mkdir -p /etc/systemd/system/kubelet.service.d
curl -sSL "https://raw.githubusercontent.com/kubernetes/release/${RELEASE_VERSION}/cmd/krel/templates/latest/kubeadm/10-kubeadm.conf" | sed "s:/usr/bin:${DOWNLOAD_DIR}:g" | sudo tee /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
systemctl enable --now kubelet
echo -e "\033[32m kube deno \033[0m"

