# kubectl

## 常用缩写

- k: kubectl
- po: pod
- ns: namespace
- no: node
- svc: service
- ep: endpoints
- cm: configmap
- pvc: persistentvolumeclaim
- pv: persistentvolume
- sts: statefulset
- cj: cronjob
- ing: ingress

## 常用选项

- -A:全部命名空间
- -n:指定命名空间
- -o:输出格式
    - wide: 显示更多信息
    - yaml: 以yaml格式输出
    - json: 以json格式输出

## kubectl get

```shell
# 查看节点
kubectl get nodes
# 查看集群中的所有资源
kubectl get all -A
# 查看集群中的所有资源，包括未初始化的资源，以yaml格式输出
kubectl get all -o yaml
# 查看pod
kubectl -A get pods 
kubectl -n kube-flannel get pods -o wide
# 查看服务
kubectl -A get service -o wide
```

## kubectl logs

```shell
# 查看pod的日志
kubectl -n kube-flannel logs -f pod-name 
```

## kubectl apply

```shell
# 创建
kubectl apply -f busybox.yaml
```

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: busybox
  namespace: default
spec:
  containers:
    - name: busybox
      image: busybox
      command: [ "sleep", "3600" ]
```

## kubectl describe

```shell
# kubectl describe TYPE name
# type = pod, service, deployment, node, namespace，pv, pvc
kubectl -n kube-system describe pod/busybox

```

## kubectl exec

```shell
# kubectl exec [-it] POD [-c CONTAINER] -- COMMAND [args...]
# -i: 允许你对容器内的标准输入 (STDIN) 进行交互
# -t: 允许你使用终端 (TTY)
kubectl -n default exec -it  busybox -- /bin/sh

```

## kubectl delete

```shell
# 删除
kubectl -n default delete pod  busybox

```
