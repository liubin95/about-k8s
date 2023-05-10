## secret

```shell
kubectl create secret generic mysql-pass --from-literal=password=YOUR_PASSWORD
```

## configMap

```shell
kubectl create configmap mysql-master-config --from-file=master.cnf

```

## pod

```shell
# 部署
kubectl apply -f mysql-pod.yaml
# 详情
kubectl describe statefulset.apps/mysql
kubectl describe pod mysql-0
# log
kubectl logs -f mysql-0
# 状态
kubectl get statefulset.apps/mysql

# 执行命令 
kubectl exec -it mysql-0 -- mysql -uroot -p
```
