# sonobuoy

## 安装
```shell
# 下载 https://github.com/vmware-tanzu/sonobuoy/releases
wget https://github.com/vmware-tanzu/sonobuoy/releases/download/v0.56.16/sonobuoy_0.56.16_linux_amd64.tar.gz
tar -zxvf sonobuoy_0.56.16_linux_amd64.tar.gz
```
## 使用
```shell
# 快速测试
./sonobuoy run --wait --mode quick

# 获取结果
./sonobuoy retrieve

# 查看结果
./sonobuoy results $(./sonobuoy retrieve)

# 删除所有
./sonobuoy delete --wait
```
