#!/bin/bash

# calicoctl tool
# 一个机器安装就行

set  -e
VERSION=3.28.0
curl -L https://github.com/projectcalico/calico/releases/download/v${VERSION}/calicoctl-linux-amd64 -o /usr/local/bin/calicoctl
chmod +x /usr/local/bin/calicoctl
calicoctl version
