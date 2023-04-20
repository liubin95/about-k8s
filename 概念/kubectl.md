# kubectl

## kubectl get

```shell
# 查看节点
kubectl get nodes
# 查看集群中的所有资源
kubectl get all --all-namespaces
# 查看集群中的所有资源，包括未初始化的资源，以yaml格式输出
kubectl get all -o yaml
# 查看pod
kubectl get pods --all-namespaces
kubectl get pods -o wide -n kube-flannel
# 查看服务
kubectl get service --all-namespaces -o wide

```

## kubectl logs

```shell
# 查看pod的日志
kubectl logs -f pod-name -n kube-flannel
```

## kubectl run

```shell
kubectl run busybox2 --image=busybox --restart=Never --sleep 3600

```

## kubectl describe

```shell
kubectl describe pod -n kube-system coredns-5d78c9869d-9dw9h

```
