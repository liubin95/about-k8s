## completion

```shell
# 生成提示脚本
minikube completion zsh > _minikube
```

## start

```shell
# 启动集群
minikube start --kubernetes-version=v1.27.3
# op  网络插件
# https://minikube.sigs.k8s.io/docs/handbook/network_policy/
minikube start --network-plugin=cni --cni=calico
# 查看集群信息
minikube status
# stop
minikube stop
# delete
minikube delete [--all]

```

## ingress

```shell
# ingress nginx
minikube addons enable ingress
# 本地访问 ingress
minikube tunnel

```

## images

```shell
# 本地镜像
eval $(minikube docker-env)

```

## dashboard

```shell
# 仪表盘
minikube dashboard

```
