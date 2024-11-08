#!/bin/bash
set -e
dnf install -y bash-completion
{
  echo "source <(kubectl completion bash)"
  echo 'alias k=kubectl'
  echo 'complete -o default -F __start_kubectl k'
} >>~/.bashrc
# shellcheck source=/dev/null
source ~/.bashrc
