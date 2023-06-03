# secret

```shell
# 新增
kubectl create secret generic my-pass --from-literal=mysql-pass=YOUR_PASSWORD
kubectl create secret generic elasticsearch-certs --from-file=elastic-certificates.p12 -n liubin

# 获取内容
kubectl get secrets my-pass -o jsonpath='{.data}'
# 修改
kubectl edit secrets my-pass
```
