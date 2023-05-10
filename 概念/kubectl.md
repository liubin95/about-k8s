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

## kubectl apply

```shell
kubectl apply -f busybox.yaml

```

## kubectl describe

```shell
# kubectl describe TYPE name
# type = pod, service, deployment, node, namespace，pv, pvc
kubectl describe pod -n kube-system coredns-5d78c9869d-9dw9h

```

## kubeclt exec

```shell
# kubectl exec [-it] POD [-c CONTAINER] -- COMMAND [args...]
# -i: 允许你对容器内的标准输入 (STDIN) 进行交互
# -t: 允许你使用终端 (TTY)
kubectl exec -it -n kube-system coredns-5d78c9869d-9dw9h -- /bin/sh

```

## kubectl delete

```shell
# kubectl delete TYPE NAME
# type = pod, service, deployment, node, namespace，pv, pvc
kubectl delete pod -n kube-system coredns-5d78c9869d-9dw9h

```
