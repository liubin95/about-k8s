# service

```shell
# 网络工具
kubectl run curl --image=radial/busyboxplus:curl -i --tty
# 解析域名
nslookup mysql-service.liubin.svc.cluster.local
# 进入容器
kubectl attach curl -c curl -i -t
```
