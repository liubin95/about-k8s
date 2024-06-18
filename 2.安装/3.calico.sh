#!/bin/bash

# test dir /etc/cni/net.d /opt/cni/bin 失败
[[ -d /etc/cni/net.d ]] || exit 1
[[ -d /opt/cni/bin ]] || exit 1

mkdir -p /etc/NetworkManager/conf.d
# 输入到文件
cat <<EOF > /etc/NetworkManager/conf.d/calico.conf
[keyfile]
unmanaged-devices=interface-name:cali*;interface-name:tunl*;interface-name:vxlan.calico;interface-name:vxlan-v6.calico;interface-name:wireguard.cali;interface-name:wg-v6.cali
EOF

# install
VERSION=3.28.0
# 自定义资源文件
curl -O https://raw.githubusercontent.com/projectcalico/calico/v${VERSION}/manifests/tigera-operator.yaml
k create -f tigera-operator.yaml
# 部署文件
curl -O https://raw.githubusercontent.com/projectcalico/calico/v${VERSION}/manifests/custom-resources.yaml
k create -f custom-resources.yaml


# 安装之后 dns 服务会启动
watch 'kubectl get pods -A | grep -E "calico|dns"'
