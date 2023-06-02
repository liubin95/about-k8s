## 部署
```shell
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml
# 创建用户
kubectl apply -f dashboard-adminuser.yaml
# 获取token
kubectl -n kubernetes-dashboard create token admin-user
# 开启代理
kubectl proxy

# 端口转发 从宿主机到虚拟机的8001
ssh -L 8001:localhost:8001 user@<proxy-host>

# 访问地址
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
```
