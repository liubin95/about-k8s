# secret

```shell
# 新增
kubectl create secret generic my-pass --from-literal=mysql-pass=YOUR_PASSWORD
# 获取内容
kubectl get secrets my-pass -o jsonpath='{.data}'
# 修改
kubectl edit secrets my-pass
```
