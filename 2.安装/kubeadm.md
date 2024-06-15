# kubeadm

## [kubeadm init](https://kubernetes.io/zh-cn/docs/reference/setup-tools/kubeadm/kubeadm-init/)

> 此命令初始化一个 Kubernetes 控制平面节点。

## [kubeadm join](https://kubernetes.io/zh-cn/docs/reference/setup-tools/kubeadm/kubeadm-join/)

> 此命令用来初始化 Kubernetes 工作节点并将其加入集群。

## [kubeadm reset](https://kubernetes.io/zh-cn/docs/reference/setup-tools/kubeadm/kubeadm-reset/)

> 该命令尽力还原由 kubeadm init 或 kubeadm join 所做的更改。

```shell
kubeadm reset --force --cleanup-tmp-dir
# The reset process does not clean CNI configuration. To do so, you must remove /etc/cni/net.d
rm -rf /etc/cni/net.d
#The reset process does not reset or clean up iptables rules or IPVS tables.
#If you wish to reset iptables, you must do so manually by using the "iptables" command.
iptables -F && iptables -t nat -F && iptables -t mangle -F && iptables -X

#If your cluster was setup to utilize IPVS, run ipvsadm --clear (or similar)
#to reset your system's IPVS tables.
ipvsadm -C

# The reset process does not clean your kubeconfig files and you must remove them manually.
# Please, check the contents of the $HOME/.kube/config file.

```
