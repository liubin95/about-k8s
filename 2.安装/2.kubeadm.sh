#!/bin/bash
set -e

kubeadm init --upload-certs --config 2.kubeadm-config.yaml


# success
export KUBECONFIG=/etc/kubernetes/admin.conf
kubeadm join 192.168.50.222:6443 --token p69uu9.m9jw3hla408h3q7o \
        --discovery-token-ca-cert-hash sha256:2ee7c953c09e4006f59a3265727b86906b376b28dc623d9339a3cfde9ba75a42

# fail
systemctl status kubelet > kubelet.log
kubeadm reset --force --cleanup-tmp-dir
