# [安装 kubeadm、kubelet 和 kubectl](https://kubernetes.io/zh-cn/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)

你需要在**每台机器**上安装以下的软件包：

- kubeadm：用来初始化集群的指令。
- kubelet：在集群中的每个节点上用来启动 Pod 和容器等。
- kubectl：用来与集群通信的命令行工具。

## 安装

```shell
# 如果由于该 Red Hat 的发行版无法解析 basearch
# 导致获取 baseurl 失败，请将 \$basearch 替换为你计算机的架构。
# 输入 uname -m 以查看该值。 例如，x86_64 的 baseurl URL 可以是：https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64。
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

```

## 配置 cgroup 驱动程序

> 所以对基于 kubeadm 的安装， 我们推荐使用 systemd 驱动，不推荐 cgroupfs 驱动。
> 说明： 在版本 1.22 中，如果用户没有在 KubeletConfiguration 中设置 cgroupDriver 字段， kubeadm 会将它设置为默认值 systemd。

```yaml
# kubeadm-config.yaml
kind: ClusterConfiguration
apiVersion: kubeadm.k8s.io/v1beta3
kubernetesVersion: v1.27.1
---
kind: KubeletConfiguration
apiVersion: kubelet.config.k8s.io/v1beta1
cgroupDriver: systemd

```

## 初始化集群

```shell
kubeadm init --pod-network-cidr=10.244.0.0/16
#  if you are the root user, you can run:
# 写入环境变量
export KUBECONFIG=/etc/kubernetes/admin.conf

# You should now deploy a pod network to the cluster.
#Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
# https://kubernetes.io/docs/concepts/cluster-administration/addons/
kubeadm join 192.168.50.222:6443 --token token \
  --discovery-token-ca-cert-hash sha256:97b0e1365436c5aaca0bb3b95ca258f8c48276a32f767da77780d5bbb7392df3

```
