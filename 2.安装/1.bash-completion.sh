#!/bin/bash
set -e
dnf install -y bash-completion
echo 'alias k=kubectl' >>~/.bashrc
echo 'complete -o default -F __start_kubectl k' >>~/.bashrc
