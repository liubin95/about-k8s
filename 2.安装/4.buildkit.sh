#!/bin/bash

# containerd 只是容器运行时，所以没有build功能，需要使用buildkit来build镜像
# 一个机器安装就行
VERSION=0.14.0

wget https://github.com/moby/buildkit/releases/download/v${VERSION}/buildkit-v${VERSION}.linux-amd64.tar.gz
tar -xzvf buildkit-v${VERSION}.linux-amd64.tar.gz -C /usr/local/
# 作为服务运行
curl -L --remote-name-all https://raw.githubusercontent.com/moby/buildkit/master/examples/systemd/system/{buildkit.service,buildkit.socket}
cp buildkit.service buildkit.socket /etc/systemd/system/
systemctl daemon-reload
systemctl enable --now buildkit
buildctl -v
echo -e "\033[32m buildkit deno \033[0m"
